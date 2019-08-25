package io.stewan.capacitor.intercom;

import com.getcapacitor.Config;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import io.intercom.android.sdk.Intercom;
import io.intercom.android.sdk.identity.Registration;

@NativePlugin()
public class IntercomPlugin extends Plugin {
    public static final String CONFIG_KEY_PREFIX = "plugins.IntercomPlugin.android-";

    @Override()
    public void load() {
        //
        // get config
        String apiKey = Config.getString(CONFIG_KEY_PREFIX + "apiKey", "ADD_IN_CAPACITOR_CONFIG_JSON");
        String appId = Config.getString(CONFIG_KEY_PREFIX + "appId", "ADD_IN_CAPACITOR_CONFIG_JSON");

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
        call.success();
    }

    @PluginMethod()
    public void registerUnidentifiedUser(PluginCall call) {
        Intercom.client().registerUnidentifiedUser();
        call.success();
    }

    @PluginMethod()
    public void logout(PluginCall call) {
        Intercom.client().logout();
        call.success();
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

        call.success();
    }

    @PluginMethod()
    public void displayMessenger(PluginCall call) {
        Intercom.client().displayMessenger();
        call.success();
    }

    @PluginMethod()
    public void displayMessageComposer(PluginCall call) {
        Intercom.client().displayMessageComposer();
        call.success();
    }

    @PluginMethod()
    public void displayHelpCenter(PluginCall call) {
        Intercom.client().displayHelpCenter();
        call.success();
    }

    @PluginMethod()
    public void hideMessenger(PluginCall call) {
        Intercom.client().hideMessenger();
        call.success();
    }

    @PluginMethod()
    public void displayLauncher(PluginCall call) {
        Intercom.client().setLauncherVisibility(Intercom.VISIBLE);
        call.success();
    }

    @PluginMethod()
    public void hideLauncher(PluginCall call) {
        Intercom.client().setLauncherVisibility(Intercom.GONE);
        call.success();
    }

 
    @PluginMethod()
    public void setBottomPadding(PluginCall call) {
        Integer bottomPadding = call.getInt("bottomPaddiing");
        Intercom.client().setBottomPadding(bottomPadding);
        call.success();
    }


    private static Map<String, Object> mapFromJSON(JSONObject jsonObject) {
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
        if (value instanceof JSONObject) {
            value = mapFromJSON((JSONObject) value);
        } else if (value instanceof JSONArray) {
            value = listFromJSON((JSONArray) value);
        }
        return value;
    }

    private static List<Object> listFromJSON(JSONArray jsonArray) {
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
