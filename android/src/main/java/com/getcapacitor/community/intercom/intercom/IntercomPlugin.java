package com.getcapacitor.community.intercom.intercom;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.UserAttributes;
import io.intercom.android.sdk.identity.Registration;


@CapacitorPlugin(name = "Intercom")
public class IntercomPlugin extends Plugin {
    public static final String CONFIG_KEY_PREFIX = "plugins.IntercomPlugin.android-";

    @Override()
    public void load() {
        //
        // get config
        String apiKey = this.getConfig().getString(CONFIG_KEY_PREFIX + "apiKey", "ADD_IN_CAPACITOR_CONFIG_JSON");
        String appId = this.getConfig().getString(CONFIG_KEY_PREFIX + "appId", "ADD_IN_CAPACITOR_CONFIG_JSON");

        //
        // init intercom sdk
        Intercom.initialize(this.getActivity().getApplication(), apiKey, appId);

        //
        // load parent
        super.load();
    }


    @PluginMethod()
    public void registerIdentifiedUser(PluginCall call) {
        String email = call.getString("email");
        String userId = call.getString("userId");

        Registration registration = new Registration();

        if (email != null && email.length() > 0) {
            registration = registration.withEmail(email);
        }
        if (userId != null && userId.length() > 0) {
            registration = registration.withUserId(userId);
        }
        Intercom.client().registerIdentifiedUser(registration);
        call.resolve();
    }

    @PluginMethod()
    public void registerUnidentifiedUser(PluginCall call) {
        Intercom.client().registerUnidentifiedUser();
        call.resolve();
    }

    @PluginMethod()
    public void updateUser(PluginCall call) {
        UserAttributes.Builder builder = new UserAttributes.Builder();
        String userId = call.getString("userId");
        if (userId != null && userId.length() > 0) {
            builder.withUserId(userId);
        }
        String email = call.getString("email");
        if (email != null && email.length() > 0) {
            builder.withEmail(email);
        }
        String name = call.getString("name");
        if (name != null && name.length() > 0) {
            builder.withName(name);
        }
        String phone = call.getString("phone");
        if (phone != null && phone.length() > 0) {
            builder.withPhone(phone);
        }
        String languageOverride = call.getString("languageOverride");
        if (languageOverride != null && languageOverride.length() > 0) {
            builder.withLanguageOverride(languageOverride);
        }
        Map<String, Object> customAttributes = mapFromJSON(call.getObject("customAttributes"));
        builder.withCustomAttributes(customAttributes);
        Intercom.client().updateUser(builder.build());
        call.resolve();
    }

    @PluginMethod()
    public void logout(PluginCall call) {
        Intercom.client().logout();
        call.resolve();
    }

    @PluginMethod()
    public void logEvent(PluginCall call) {
        String eventName = call.getString("name");
        Map<String, Object> metaData = mapFromJSON(call.getObject("data"));

        if (metaData == null) {
            Intercom.client().logEvent(eventName);
        } else {
            Intercom.client().logEvent(eventName, metaData);
        }

        call.resolve();
    }

    @PluginMethod()
    public void displayMessenger(PluginCall call) {
        Intercom.client().displayMessenger();
        call.resolve();
    }

    @PluginMethod()
    public void displayMessageComposer(PluginCall call) {
        Intercom.client().displayMessageComposer();
        call.resolve();
    }

    @PluginMethod()
    public void displayHelpCenter(PluginCall call) {
        Intercom.client().displayHelpCenter();
        call.resolve();
    }

    @PluginMethod()
    public void hideMessenger(PluginCall call) {
        Intercom.client().hideIntercom();
        call.resolve();
    }

    @PluginMethod()
    public void displayLauncher(PluginCall call) {
        Intercom.client().setLauncherVisibility(Intercom.VISIBLE);
        call.resolve();
    }

    @PluginMethod()
    public void hideLauncher(PluginCall call) {
        Intercom.client().setLauncherVisibility(Intercom.GONE);
        call.resolve();
    }

    @PluginMethod()
    public void displayInAppMessages(PluginCall call) {
        Intercom.client().setInAppMessageVisibility(Intercom.VISIBLE);
        call.resolve();
    }

    @PluginMethod()
    public void hideInAppMessages(PluginCall call) {
        Intercom.client().setLauncherVisibility(Intercom.GONE);
        call.resolve();
    }

    @PluginMethod()
    public void displayCarousel(PluginCall call) {
        String carouselId = call.getString("carouselId");
        Intercom.client().displayCarousel(carouselId);
        call.resolve();
    }

    @PluginMethod()
    public void setUserHash(PluginCall call) {
        String hmac = call.getString("hmac");
        Intercom.client().setUserHash(hmac);
        call.resolve();
    }

    @PluginMethod()
    public void setBottomPadding(PluginCall call) {
        String stringValue = call.getString("value");
        int value = Integer.parseInt(stringValue);
        Intercom.client().setBottomPadding(value);
        call.resolve();
    }

    private static Map<String, Object> mapFromJSON(JSObject jsonObject) {
        if (jsonObject == null) {
            return null;
        }
        Map<String, Object> map = new HashMap<>();
        Iterator<String> keysIter = jsonObject.keys();
        while (keysIter.hasNext()) {
            String key = keysIter.next();
            Object value = getObject(jsonObject.opt(key));
            if (value != null) {
                map.put(key, value);
            }
        }
        return map;
    }

    private static Object getObject(Object value) {
        if (value instanceof JSObject) {
            value = mapFromJSON((JSObject) value);
        } else if (value instanceof JSArray) {
            value = listFromJSON((JSArray) value);
        }
        return value;
    }

    private static List<Object> listFromJSON(JSArray jsonArray) {
        List<Object> list = new ArrayList<>();
        for (int i = 0, count = jsonArray.length(); i < count; i++) {
            Object value = getObject(jsonArray.opt(i));
            if (value != null) {
                list.add(value);
            }
        }
        return list;
    }
}
