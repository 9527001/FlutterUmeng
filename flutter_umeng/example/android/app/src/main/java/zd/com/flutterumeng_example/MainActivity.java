package zd.com.flutterumeng_example;

import android.content.Intent;
import android.os.Bundle;


import androidx.annotation.NonNull;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
//  @Override
//  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
//    super.onActivityResult(requestCode, resultCode, data);
//    UMShareAPI.get(this).onActivityResult(requestCode,resultCode,data);
//  }
}
