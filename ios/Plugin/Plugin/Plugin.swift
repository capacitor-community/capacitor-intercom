import Foundation
import Capacitor
import Intercom

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(IntercomPlugin)
public class IntercomPlugin: CAPPlugin {
  
  public override func load() {
    let apiKey = getConfigValue("ios-apiKey") as? String ?? "ADD_IN_CAPACITOR_CONFIG_JSON"
    let appId = getConfigValue("ios-appId") as? String ?? "ADD_IN_CAPACITOR_CONFIG_JSON"
    Intercom.setApiKey(apiKey, forAppId: appId)
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.didRegisterWithToken(notification:)), name: Notification.Name(CAPNotifications.DidRegisterForRemoteNotificationsWithDeviceToken.name()), object: nil)
  }
  
  
  @objc func didRegisterWithToken(notification: NSNotification) {
    guard let deviceToken = notification.object as? Data else {
      return
    }
    Intercom.setDeviceToken(deviceToken)
  }
  
  @objc func registerIdentifiedUser(_ call: CAPPluginCall) {
    let userId = call.getString("userId")
    let userEmail = call.getString("userEmail")
    
    if (userId != nil && userEmail != nil) {
      Intercom.registerUser(withUserId: userId!, email: userEmail!)
      call.success()
    }else if (userId != nil) {
      Intercom.registerUser(withUserId: userId!)
      call.success()
    }else if (userEmail != nil) {
      Intercom.registerUser(withEmail: userEmail!)
      call.success()
    }else{
      call.error("No user registered. You must supply an email, userId or both")
    }
  }
  
  @objc func registerUnidentifiedUser(_ call: CAPPluginCall) {
    Intercom.registerUnidentifiedUser()
    call.success()
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
    Intercom.updateUser(userAttributes)
    call.success()
  }
  
  @objc func logout(_ call: CAPPluginCall) {
    Intercom.logout()
    call.success()
  }
  
  @objc func logEvent(_ call: CAPPluginCall) {
    let eventName = call.getString("name")
    let metaData = call.getObject("data")
    
    if (eventName != nil && metaData != nil) {
      Intercom.logEvent(withName: eventName!, metaData: metaData!)
      
    }else if (eventName != nil) {
      Intercom.logEvent(withName: eventName!)
    }
    
    call.success()
  }
  
  @objc func displayMessenger(_ call: CAPPluginCall) {
    Intercom.presentMessenger();
    call.success()
  }
  
  @objc func displayMessageComposer(_ call: CAPPluginCall) {
    guard let initialMessage = call.getString("message") else {
      call.error("Enter an initial message")
      return
    }
    Intercom.presentMessageComposer(initialMessage);
    call.success()
  }
  
  @objc func displayHelpCenter(_ call: CAPPluginCall) {
    Intercom.presentHelpCenter()
    call.success()
  }
  
  @objc func hideMessenger(_ call: CAPPluginCall) {
    Intercom.hide()
    call.success()
  }
  
  @objc func displayLauncher(_ call: CAPPluginCall) {
    Intercom.setLauncherVisible(true)
    call.success()
  }
  
  @objc func hideLauncher(_ call: CAPPluginCall) {
    Intercom.setLauncherVisible(false)
    call.success()
  }
  
  @objc func displayInAppMessages(_ call: CAPPluginCall) {
    Intercom.setInAppMessagesVisible(true)
    call.success()
  }
    
  @objc func hideInAppMessages(_ call: CAPPluginCall) {
    Intercom.setInAppMessagesVisible(false)
    call.success()
  }
    
  @objc func displayCarousel(_ call: CAPPluginCall) {  
    if let carouselId = call.getString("carouselId") {
        Intercom.presentCarousel(carouselId)
        call.success()
    }else{
      call.error("carouselId not provided to displayCarousel.")
    }
  }
    
  @objc func setUserHash(_ call: CAPPluginCall) {
    let hmac = call.getString("hmac")
    
    if (hmac != nil) {
      Intercom.setUserHash(hmac!)
      call.success()
      print("hmac sent to intercom")
    }else{
      call.error("No hmac found. Read intercom docs and generate it.")
    }
  }

  @objc func setBottomPadding(_ call: CAPPluginCall) {

    if let value = call.getString("value"),
      let number = NumberFormatter().number(from: value) {

        Intercom.setBottomPadding(CGFloat(truncating: number))
        call.success()
        print("set bottom padding")
      } else {
        call.error("Enter a value for padding bottom")
      }
  }
  
}
