import 'package:flutter/material.dart';
import 'package:flutter_build_xocdia/controller/splash_controller.dart';
import 'package:flutter_build_xocdia/widget/game_text.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DiceRollingSplash extends StatelessWidget {
   DiceRollingSplash({super.key});
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade600,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gameText(
              text: "Dice Rolling Bet  ", 
              color: Colors.white, 
              fontSize: 25, 
              fontWeight: FontWeight.bold
            ),
            LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}