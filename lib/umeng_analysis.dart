import 'package:flutter/services.dart';

class UMengAnalysis {
  static const MethodChannel _channel = const MethodChannel('flutterumeng');

  static void onEvent(String event, Map<String,dynamic> properties) {
    List<dynamic> args = [event,properties];
    _channel.invokeMethod('onEvent', args);
  }

  static void onProfileSignIn (String userID) {
    List<dynamic> args = [userID];
    _channel.invokeMethod('onProfileSignIn', args);
  }

  static void onProfileSignOff () {
    _channel.invokeMethod('onProfileSignOff');
  }

  static void setPageCollectionModeManual() {
    _channel.invokeMethod('setPageCollectionModeManual');
  }

  static void onPageStart(String viewName) {
    List<dynamic> args = [viewName];
    _channel.invokeMethod('onPageStart', args);
  }

  static void onPageEnd(String viewName) {
    List<dynamic> args = [viewName];
    _channel.invokeMethod('onPageEnd', args);
  }

  static void setPageCollectionModeAuto() {
    _channel.invokeMethod('setPageCollectionModeAuto');
  }

  static void reportError(String error) {
    List<dynamic> args = [error];
    _channel.invokeMethod('reportError', args);
  }
}