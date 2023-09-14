import 'package:flutter/material.dart';
import 'package:flutter_build_xocdia/controller/dice_controller.dart';
import 'package:flutter_build_xocdia/widget/game_text.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../color/app_color.dart';
import '../widget/balance_bet.dart';
import '../widget/bet_button.dart';
import '../widget/board.dart';
// ignore: must_be_immutable
class XocDiaGamePage extends StatelessWidget {
  XocDiaGamePage({super.key});
  DiceController controller = Get.put(DiceController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    debugPrint(" width :$width");
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: width,
            decoration:  BoxDecoration(
              color: backgroundColor,
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/Dice Bord copy.png",
                ),
                fit: BoxFit.fill
              )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                GetBuilder(
                  init: DiceController(),
                  builder: (controller) {
                    return Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        ShakeWidget(
                          shakeConstant: ShakeHardConstant1(),
                          autoPlay: controller.stopDiceAnimation.value,
                          duration: const Duration(seconds: 2),
                          enableWebMouseHover: true,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 180,
                                width: width,
                                //color: Colors.red,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 150,
                                width: 170,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/PLATE.png'
                                    ),
                                    fit: BoxFit.fill
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/dice${controller.dice1}.png',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(width: 3,),
                                    Image.asset(
                                      'assets/images/dice${controller.dice2}.png',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ), //width/2-85
                              AnimatedPositioned(
                                left: controller.isLIDPosition.value?-100:width/2-85,
                                top: 0,
                                duration: const Duration(milliseconds: 700),
                                child: Image.asset(
                                  'assets/images/Cup Dic.png',
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.fill,
                                )
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: Obx(() => Stack(
                            alignment: Alignment.center,
                              children: [
                                Container(
                                  height: width/2*0.25,
                                  width: width/2*0.25,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/Clock.png"
                                      ),
                                      fit: BoxFit.fill
                                    )
                                  ),
                                ),
                                gameText(
                                  text: controller.stopTimer.value.toString(), 
                                  color: Colors.black,
                                  fontSize: 25, 
                                  fontWeight: FontWeight.bold
                                )
                              ],
                            ),),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  margin:  const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 60,
                    bottom: 10
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30
                  ),
                  decoration: BoxDecoration(
                    //color: Colors.black.withOpacity(0.15),
                    borderRadius:  BorderRadius.circular(10),
                    // border: Border.all(
                    //   width: 1,
                    //   color: Colors.white24
                    // ),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/Bar Result fram number.png"
                      ),
                      fit: BoxFit.fill
                    )
                  ),
                  //alignment: Alignment.center,
                 // color: Colors.amber,
                  //width: width,
                  height: 50,
                  child:  FittedBox(
                    child: Obx(() =>  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BalanceBet(
                          image: "assets/images/coin.png",
                          //text: "",
                          amount: controller.balance.value.toDouble(),
                        ),
                        const SizedBox(width: 30,),
                         BalanceBet(
                          image: "assets/images/coinbet.png",
                          //text: "",
                          amount: controller.betAmout.value.toDouble(),
                         // amount: controller.oneBetAmout.value.toDouble(),
                        )
                      ],
                    ),)
                  ),
                ),
                GetBuilder(
                  init: DiceController(),
                  builder: (controller) {
                    return Container(
                  alignment: Alignment.center,
                  height: width/2 *0.5 + (width/2 *0.35)*2 + 1.3 * 6,
                  width: width,
                 //color: Colors.amber,
                  child: Wrap(
                    children: [
                      ...List.generate(// ((width/2 *0.65)*2+(width/2 *0.4))/5
                        13, (index){
                          return ZoomTapAnimation(
                            onTap: () {
                              controller.addALLTHEBET(index,controller.betCurrentIndex.value);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Board(
                                 // color: controller.listboardColor[index], 
                                  height: index>2?width/2 *0.35:width/2 *0.5, 
                                  width: index==1?width/2 *0.4+1.3*4:
                                  index==0 || index==2?width/2 *0.65:((width/2 *0.65)*2+(width/2 *0.4))/5,
                                  pay: controller.listPay[index],
                                  number: controller.listNumber[index],
                                  isDiceShow: controller.listDiceShow[index],
                                ),
                                ...List.generate(
                                  controller.listBetAmount[index].length, (i){
                                    return Positioned(
                                      left: controller.listBetPosition[index][i],
                                      child: controller.listBetAmount[index][i]==0?const Text(""):Container(
                                        alignment: Alignment.center,
                                        height: width/2*0.1,
                                        width: width/2*0.1,
                                        decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/${controller.listBetAmount[index][i]}K.png"
                                            ),
                                            fit: BoxFit.cover
                                          ),
                                        )),
                                    );
                                  })
                              ],
                            ),
                          );
                        })
                    ],
                  ),
                );
                  },
                ),
                Container(
                  width: width,
                  height: height/2*0.2,
                 //color: Colors.teal,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ZoomTapAnimation(
                        onTap: () {
                          controller.reSetGame();
                        },
                        child: const BetButton(
                          image: "assets/images/Return button.png",
                        ),
                      ),
                      Padding(
                         padding: const EdgeInsets.symmetric(
                          horizontal: 10
                         ),
                         child: Obx(() => SpeedDial(
                           backgroundColor: Colors.transparent,
                           overlayColor: Colors.black,
                           overlayOpacity: 0.2,
                           children: [
                            ...List.generate(
                             controller.listBet.length, (index){
                              return  SpeedDialChild(
                               backgroundColor: Colors.transparent,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(100),
                               ),
                               child: Container(
                                 alignment: Alignment.center,
                                 height: width/2*0.2,
                                 width: width/2*0.2,
                                 decoration:  BoxDecoration(
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                     image: AssetImage(
                                       controller.listBet[index]
                                     ),
                                     fit: BoxFit.cover
                                   ),
                                 )),
                               onTap: (){
                                 controller.setBetIndex(index);
                               }
                             );
                             })
                           ],
                           child: Container(
                           alignment: Alignment.center,
                           height: width/2*0.2,
                           width: width/2*0.2,
                           decoration:  BoxDecoration(
                             shape: BoxShape.circle,
                             image: DecorationImage(
                               image: AssetImage(
                                 controller.listBet[controller.betCurrentIndex.value]
                               ),
                               fit: BoxFit.fill
                             ),
                           )),
                         ),),
                       ),
                      //  ZoomTapAnimation(
                      //   onTap: () {
                      //     controller.reSetGame();
                      //   },
                      //   child: const BetButton(
                      //     iconName: Icons.restart_alt,
                      //     type: "reset",
                      //   ),
                      // ),
                      // const SizedBox(width: 10,),
                      ZoomTapAnimation(
                        onTap: () {
                          controller.clearBet();
                        },
                        child: const BetButton(
                          image: "assets/images/Clost Button.png",
                        ),
                      ),
                    ],
                  ),
                )
                
              ],
            ),
          )
        ],
      )
    );
  }
}