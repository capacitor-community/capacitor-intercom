#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(IntercomPlugin, "Intercom",
           CAP_PLUGIN_METHOD(registerIdentifiedUser, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(registerUnidentifiedUser, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(updateUser, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(logout, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(logEvent, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayMessenger, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayMessageComposer, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayHelpCenter, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hideMessenger, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayLauncher, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hideLauncher, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayInAppMessages, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hideInAppMessages, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(displayCarousel, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setUserHash, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setBottomPadding, CAPPluginReturnPromise);
)
