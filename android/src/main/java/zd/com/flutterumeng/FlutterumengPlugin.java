package zd.com.flutterumeng;

import android.app.Activity;
import android.content.Intent;

import com.umeng.socialize.UMShareAPI;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * FlutterumengPlugin
 */
public class FlutterumengPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener, PluginRegistry.RequestPermissionsResultListener {

    private Registrar registrar;
    static MethodChannel channel;
    private final Activity activity;


    public FlutterumengPlugin(Registrar registrar, Activity activity) {
        this.registrar = registrar;
        this.activity = activity;
    }

    public static void registerWith(Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), "flutterumeng");
        channel.setMethodCallHandler(new FlutterumengPlugin(registrar, registrar.activity()));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        boolean resultCode = new FlutterUMengPluginForCommon().onMethodCall(registrar, activity, call, result);
        if (resultCode) return;
        resultCode = new FlutterUMengPluginForShare().onMethodCall(registrar, activity,call, result);
        if (resultCode) return;
        resultCode = new FlutterUMengPluginForAnalysis().onMethodCall(call, result);
        if (resultCode) return;
        result.notImplemented();
//        try {
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            android.util.Log.e("Umeng", "Exception:" + e.getMessage());
//        }
    }


    @Override
    public boolean onActivityResult(int i, int i1, Intent intent) {
        UMShareAPI.get(activity.getApplicationContext()).onActivityResult(i, i1, intent);
        return true;
    }

    @Override
    public boolean onRequestPermissionsResult(int i, String[] strings, int[] ints) {
        return false;
    }
}

