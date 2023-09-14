import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
class DiceRollingAF{
  late AppsflyerSdk appsflyerSdk ;
  void diceRolingConfix()async{
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "LFdx3VQygnzBQ85prs43c8",
      appId: "appID",
      timeToWaitForATTUserAuthorization: 10.0
    );
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  }
  void diceRollingInit()async{
    appsflyerSdk.initSdk(
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
      registerConversionDataCallback: true,
    );
 } 
  Future<bool?> diceLogEvent({required String diceRollingEvent,required Map<dynamic,dynamic> diceRollingValue}){
  List<String> list=[
    "Green",
    "Red",
    "Brown",
    "Grey",
    "Yellow"
  ];
  var color = list.firstWhere((element) => element=="Red");
  debugPrint(color);
  return appsflyerSdk.logEvent(diceRollingEvent, diceRollingValue);
 }
}