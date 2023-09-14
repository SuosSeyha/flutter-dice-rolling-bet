import 'dart:io';

import 'package:flutter_build_xocdia/helper/dice_rolling_af.dart';
import 'package:flutter_build_xocdia/helper/game_helper.dart';
import 'package:flutter_build_xocdia/page/dice_rolling_home.dart';
import 'package:get/get.dart';
class SplashController extends GetxController{
   String afStatus="";
   String diceRollingUID="&appsflyerid";
   String appLanguage="";
   DiceRollingAF diceRollingAF = DiceRollingAF();
   Future<void> diceRollingSplashScreen()async{
    appLanguage = Platform.localeName.substring(0,2);
    GameHelper.getPage().then((value){
      if(value==null){
        diceRollingAF.diceRolingConfix();
        diceRollingAF.diceRollingInit();
        diceRollingAF.appsflyerSdk.onInstallConversionData((data){
          afStatus=data['payload']['af_status'];
          //afStatus="Non-organic";
          if(afStatus=="Organic"){
            Get.off(()=>DiceRollingHome(
              isState: false,
              diceRollingUID: "",
              diceRollingAF: diceRollingAF,
            ));
          }

          if(afStatus=="Non-organic"){
            if(appLanguage=="vi"){
              GameHelper.setPage(game: true);
              diceRollingAF.appsflyerSdk.getAppsFlyerUID().then((value){
                Get.off(()=>DiceRollingHome(
                  isState: true,
                  diceRollingUID: "$diceRollingUID$value",
                  diceRollingAF: diceRollingAF,
                ));
              });
            }else{
              Get.off(()=>DiceRollingHome(
                isState: false,
                diceRollingUID: "",
                diceRollingAF: diceRollingAF,
              ));
            }
          }

          if(afStatus=="" || afStatus==null){
            Get.off(()=>DiceRollingHome(
              isState: false,
              diceRollingUID: "",
              diceRollingAF: diceRollingAF,
            ));
          }
        });
      }else{
        diceRollingAF.diceRolingConfix();
        diceRollingAF.diceRollingInit();
        diceRollingAF.appsflyerSdk.onInstallConversionData((data){
          afStatus=data['payload']['af_status'];
          if(afStatus=="" || afStatus==null){
              Get.off(()=>DiceRollingHome(
                isState: false,
                diceRollingUID: "",
                diceRollingAF: diceRollingAF,
              ));
            }
            if(afStatus=="Non-organic"){
                diceRollingAF.appsflyerSdk.getAppsFlyerUID().then((value){
                Get.off(()=>DiceRollingHome(
                isState: true,
                diceRollingUID: "$diceRollingUID$value",
                diceRollingAF: diceRollingAF,
              ));
            });
            }
          
        });
      }
    });
   }

  @override
  void onInit() {
    super.onInit();
    diceRollingSplashScreen();
  }
}