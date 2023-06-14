import Foundation
import Capacitor
import Intercom

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(IntercomPlugin)
public class IntercomPlugin: CAPPlugin {

    private var opened = false;
    private var messages = Intercom.unreadConversationCount();
    
    public override func load() {
        let apiKey = getConfig().getString("iosApiKey") ?? "ADD_IN_CAPACITOR_CONFIG_JSON"
        let appId = getConfig().getString("iosAppId") ?? "ADD_IN_CAPACITOR_CONFIG_JSON"
        Intercom.setApiKey(apiKey, forAppId: appId)

#if DEBUG
        Intercom.enableLogging()
#endif

        NotificationCenter.default.addObserver(self, selector: #selector(self.didRegisterWithToken(notification:)), name: Notification.Name.capacitorDidRegisterForRemoteNotifications, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.addUnreadConversationCountListener(notification:)), name: NSNotification.Name.IntercomUnreadConversationCountDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showMessenger(_:)), name: NSNotification.Name.IntercomWindowWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeMessenger(_:)), name: NSNotification.Name.IntercomWindowDidHide, object: nil)
    }

    @objc func getUnreadConversationCount(_ call: CAPPluginCall) {
        call.resolve(["unreadMessages": Intercom.unreadConversationCount()])
    }

    @objc func getChatOpenedStatus(_ call: CAPPluginCall) {
        call.resolve(["isChatOpen": opened]);
    }

    @objc func showMessenger(_ call: CAPPluginCall) {
        // print("showMessenger called")
        opened = true
        messages = 0
    }

    @objc func closeMessenger(_ call: CAPPluginCall) {
        // print("hide notification called")
        opened = false;
    }

    @objc func addUnreadConversationCountListener(notification: NSNotification) {
        print("initial count ", messages)
        let unreadCount = Intercom.unreadConversationCount()
        print("after count ", unreadCount)
        messages = messages + unreadCount
        notifyListeners("IntercomUnreadConversationCountDidChange", data: ["unreadMessages": messages])
        // call.resolve()
    }

    @objc func didRegisterWithToken(notification: NSNotification) {
        guard let deviceToken = notification.object as? Data else {
            return
        }
        Intercom.setDeviceToken(deviceToken)
    }

    @objc func registerIdentifiedUser(_ call: CAPPluginCall) {
        let userId = call.getString("userId")
        let email = call.getString("email")
        let attributes = ICMUserAttributes()

        if ((email) != nil) {
            attributes.email = email
            Intercom.loginUser(with: attributes) { result in
                switch result {
                    case .success: call.resolve()
                    case .failure(let error): call.reject("Error logging in: \(error.localizedDescription)")
                }
            }
        }

        if ((userId) != nil) {
            attributes.userId = userId
            Intercom.loginUser(with: attributes) { result in
                switch result {
                    case .success: call.resolve()
                    case .failure(let error): call.reject("Error logging in: \(error.localizedDescription)")
                }
            }
        }
    }

    @objc func registerUnidentifiedUser(_ call: CAPPluginCall) {
        Intercom.loginUnidentifiedUser()
        call.resolve()
    }

    @objc func updateUser(_ call: CAPPluginCall) {
        let userAttributes = ICMUserAttributes()
        let userId = call.getString("userId")
        if (userId != nil) {
            userAttributes.userId = userId
        }
        let email = call.getString("email")
        if (email != nil) {
            userAttributes.email = email
        }
        let name = call.getString("name")
        if (name != nil) {
            userAttributes.name = name
        }
        let phone = call.getString("phone")
        if (phone != nil) {
            userAttributes.phone = phone
        }
        let languageOverride = call.getString("languageOverride")
        if (languageOverride != nil) {
            userAttributes.languageOverride = languageOverride
        }
        let customAttributes = call.getObject("customAttributes")
        userAttributes.customAttributes = customAttributes
        Intercom.updateUser(with: userAttributes)
        call.resolve()
    }

    @objc func logout(_ call: CAPPluginCall) {
        Intercom.logout()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("IntercomUnreadConversationCountDidChange"), object: nil);
        call.resolve()
    }

    @objc func logEvent(_ call: CAPPluginCall) {
        let eventName = call.getString("name")
        let metaData = call.getObject("data")

        if (eventName != nil && metaData != nil) {
            Intercom.logEvent(withName: eventName!, metaData: metaData!)

        }else if (eventName != nil) {
            Intercom.logEvent(withName: eventName!)
        }

        call.resolve()
    }

    @objc func displayMessenger(_ call: CAPPluginCall) {
        Intercom.present();
        call.resolve()
    }

    @objc func displayMessageComposer(_ call: CAPPluginCall) {
        guard let initialMessage = call.getString("message") else {
            call.reject("Enter an initial message")
            return
        }
        Intercom.presentMessageComposer(initialMessage);
        call.resolve()
    }

    @objc func displayHelpCenter(_ call: CAPPluginCall) {
        Intercom.presentHelpCenter()
        call.resolve()
    }

    @objc func hideMessenger(_ call: CAPPluginCall) {
        print("hide messenger called")
        Intercom.hide()
        call.resolve()
    }

    @objc func displayLauncher(_ call: CAPPluginCall) {
        Intercom.setLauncherVisible(true)
        call.resolve()
    }

    @objc func hideLauncher(_ call: CAPPluginCall) {
        Intercom.setLauncherVisible(false)
        call.resolve()
    }

    @objc func displayInAppMessages(_ call: CAPPluginCall) {
        Intercom.setInAppMessagesVisible(true)
        call.resolve()
    }

    @objc func hideInAppMessages(_ call: CAPPluginCall) {
        print("hide in app messages")
        Intercom.setInAppMessagesVisible(false)
        call.resolve()
    }

    @objc func displayCarousel(_ call: CAPPluginCall) {
        if let carouselId = call.getString("carouselId") {
            Intercom.presentCarousel(carouselId)
            call.resolve()
        }else{
            call.reject("carouselId not provided to displayCarousel.")
        }
    }

    @objc func setUserHash(_ call: CAPPluginCall) {
        let hmac = call.getString("hmac")

        if (hmac != nil) {
            Intercom.setUserHash(hmac!)
            call.resolve()
            print("hmac sent to intercom")
        }else{
            call.reject("No hmac found. Read intercom docs and generate it.")
        }
    }

    @objc func setBottomPadding(_ call: CAPPluginCall) {

        if let value = call.getString("value"),
           let number = NumberFormatter().number(from: value) {

            Intercom.setBottomPadding(CGFloat(truncating: number))
            call.resolve()
            print("set bottom padding")
        } else {
            call.reject("Enter a value for padding bottom")
        }
    }

    @objc func displayArticle(_ call: CAPPluginCall) {
        if let articleId = call.getString("articleId") {
            Intercom.presentArticle(articleId)
            call.resolve()
        } else {
            call.reject("articleId not provided to presentArticle.")
        }
    }
}
