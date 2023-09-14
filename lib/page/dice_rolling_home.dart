import 'package:flutter/material.dart';
import 'package:flutter_build_xocdia/helper/dice_rolling_af.dart';
import 'package:flutter_build_xocdia/page/xocdia_gamepage.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'dice_rolling_view.dart';

class DiceRollingHome extends StatelessWidget {
  final String diceRollingUID;
  final bool isState;
  final DiceRollingAF diceRollingAF;
  const DiceRollingHome({
    super.key,
    required this.diceRollingUID,
    required this.isState,
    required this.diceRollingAF
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isState?DiceRollingView(
      diceRollingUID: diceRollingUID,
      diceRollingAF: diceRollingAF,
    ) :Scaffold(
     body: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/Dice Bord copy.png",
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        
        Positioned(
          top: height*0.1,
          child: Column(
            children: [
              Image.asset(
                "assets/images/Loading Tai Xui.png",
                height: width*0.7,
                width: width*0.7,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 50,),
              ZoomTapAnimation(
                onTap: () {
                  Get.off(()=>XocDiaGamePage());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage( 
                      image: AssetImage(
                        "assets/images/Button start.png"
                      ),
                      fit: BoxFit.fill
                    )
                  ),
                ),
              ),
            ],
          ),
        )
      ],
     ),
    );
  }
}