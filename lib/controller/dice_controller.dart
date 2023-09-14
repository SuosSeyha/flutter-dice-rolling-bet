import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_build_xocdia/helper/game_helper.dart';
import 'package:get/get.dart';
class DiceController extends GetxController{
  RxList listBet=[
    "assets/images/10K.png",
    "assets/images/20K.png",
    "assets/images/50K.png",
    "assets/images/100K.png",
  ].obs;
  RxList listPay=[
    "1:2",
    "1:4",
    "1:2",
    "1:26",
    "1:12",
    "1:8",
    "1:6",
    "1:5",
    "1:5",
    "1:6",
    "1:8",
    "1:12",
    "1:26"
  ].obs;
  RxList listNumber=[
    "2-6",
    "7",
    "8-12",
    "2",
    "3",
    "4",
    "5",
    "6",
    "8",
    "9",
    "10",
    "11",
    "12",
  ].obs;
  List<List> listBetAmount=[
    [0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0]
  ];
  List<List<double>> listBetPosition=[
    [0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0],[0.0]
  ];
  RxList listBetTotal=[].obs;
  RxList listBetNumber=[
    10,20,50,100
  ].obs;
  RxList listBetGame=[
    0,0,0,0,0,0,0,0,0,0,0,0,0,
  ].obs;
  RxInt balance=10000.obs;
  RxInt betAmout=0.obs;
  RxInt betCurrentIndex=0.obs;
  RxInt betNumber=0.obs;
  RxInt dice1=1.obs;
  RxInt dice2=1.obs;
  RxInt addictionDice=0.obs;
  RxInt stopTimer=15.obs;
  RxInt checkTimer=5.obs;
  RxBool stopDiceAnimation=false.obs;
  RxBool isLIDPosition=false.obs;
  RxBool isDoubleBet=false.obs;
  RxBool isBet=true.obs;
  RxInt position =0.obs;
  RxInt top=0.obs;
  RxInt bottom=0.obs;
  RxInt left=0.obs;
  RxInt right=0.obs;
  RxInt winAmount=0.obs;
  RxInt step=0.obs;
  RxList listDiceShow=[
    false,false,false,false,false,
    false,false,false,false,false,
    false,false,false,
  ].obs;
  void diceRandom(){
    dice1.value=Random().nextInt(6)+1;
    dice2.value=Random().nextInt(6)+1;
    addictionDice.value=dice1.value+dice2.value;
    debugPrint("addictionDice: $addictionDice");
  }
  void gameTimePlay(){
    Timer.periodic(const Duration(seconds: 1), (timer) { 
      if(stopTimer.value>0){
        stopTimer--;
      }
      if(stopTimer.value>=13){
        stopDiceAnimation.value=true;
        isBet.value=true;
      }
      if(stopTimer.value==11){
        diceRandom();
        stopDiceAnimation.value=false;
      }
      if(stopTimer.value==0){
        isBet.value=false;
        checkTimer.value=5;
        isLIDPosition.value=true;
        Timer.periodic(const Duration(seconds: 1), (timeDice) { 
        if(checkTimer.value>0){
          checkTimer--;
          step++;
          if(step.value==1){
            checkDiceWin();
          }
        }else{
          betAmout.value=0;
          clearTimer();
          timeDice.cancel();
        }
      });
      }
      update();
    });
  }
  void clearTimer(){
    step.value=0;
    isLIDPosition.value=false;
    stopTimer.value=15;
    
    winAmount.value=0;
    listBetGame=[
      0,0,0,0,0,0,0,0,0,0,0,0,0,
    ].obs;
    listBetAmount=[
      [0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0]
    ];
    listBetPosition=[
      [0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0],[0]
    ];
    listDiceShow=[
      false,false,false,false,false,
      false,false,false,false,false,
      false,false,false,
    ].obs;
  }
  void setBetIndex(int index){
    betCurrentIndex.value=index;
  }
  void addTOTALBET(int index,int betValue){
    listBetAmount[index].add(listBetNumber[betValue]);
    listBetPosition[index].add(listBetAmount[index].length*2);
    balance-=listBetNumber[betValue];
    debugPrint("listBetAmount: $listBetAmount");
    betAmout+=listBetNumber[betValue]; 
    listBetGame[index]+=listBetNumber[betValue];
  }
  void addALLTHEBET(int index,int betValue){
    if(isBet.value){
      if(listBetNumber[betValue]==10){
      if(balance>=10){
        addTOTALBET(index,betValue);
      }
    }
    if(listBetNumber[betValue]==20){
      if(balance>=20){
        addTOTALBET(index,betValue);
      }
    }
    if(listBetNumber[betValue]==50){
      if(balance>=50){
        addTOTALBET(index,betValue);
      }
    }
    if(listBetNumber[betValue]==100){
      if(balance>=100){
        addTOTALBET(index,betValue);
      }
    }
    }
    update();
  }
  void clearBet(){
    clearTimer();
    stopTimer.value=15;
    balance.value+=betAmout.value;
    betAmout.value=0;
    update();
  }
  void totalWinOne({required int index,required int sumDic,required int multiplier}){
    if(addictionDice.value==sumDic){
      listDiceShow[index]=true;
      winAmount.value=listBetGame[index]*multiplier;
      balance.value+=winAmount.value;
      GameHelper.setTotalBalance(totalAmount: balance.value);
    }
  }
  void totalWinMuch({required int index, required multiplier,required int start, required int end}){
    if(addictionDice.value>=start && addictionDice.value<=end){
      listDiceShow[index]=true;
      winAmount.value=listBetGame[index]*multiplier;
      balance.value+=winAmount.value;
      GameHelper.setTotalBalance(totalAmount: balance.value);
    }
  }
  void checkDiceWin(){
    for(int i=0;i<13;i++){
      if(i==0){
        totalWinMuch(index: i,multiplier: 2,start: 2,end: 6);
      }
      if(i==1){
        totalWinOne(index: i,sumDic: 7,multiplier: 4);
      }
      if(i==2){
        totalWinMuch(index: i,multiplier: 2,start: 8,end: 12);
      }
      if(i==3){
        totalWinOne(index: i,sumDic: 2,multiplier: 26);
      }
      if(i==4){
        totalWinOne(index: i,sumDic: 3,multiplier: 12);
      }
      if(i==5){
        totalWinOne(index: i,sumDic: 4,multiplier: 8);
      }
      if(i==6){
        totalWinOne(index: i,sumDic: 5,multiplier: 6);
      }
      if(i==7){
        totalWinOne(index: i,sumDic: 6,multiplier: 5);
      }
      if(i==8){
        totalWinOne(index: i,sumDic: 8,multiplier: 5);
      }
      if(i==9){
        totalWinOne(index: i,sumDic: 9,multiplier: 6);
      }
      if(i==10){
        totalWinOne(index: i,sumDic: 10,multiplier: 8);
      }
      if(i==11){
        totalWinOne(index: i,sumDic: 11,multiplier: 12);
      }
      if(i==12){
        totalWinOne(index: i,sumDic: 12,multiplier: 26);
      }
    }
  }
  void totalPref(){
    GameHelper.getTotalBalance().then((totalBalance){
      if(totalBalance==null){
        GameHelper.setTotalBalance(totalAmount: 10000);
        balance.value=10000;
      }else{
        balance.value=totalBalance;
      }
    });
  }
  void reSetGame(){
    Get.defaultDialog(
      title: "Game",
      middleText: "You want to reset game?",
      onConfirm: () {
        GameHelper.setTotalBalance(totalAmount: 10000);
        balance.value=10000;
        clearBet();
        Get.back();
      },
      onCancel: () {
        
      },
      barrierDismissible: false
    );
  }
  @override
  void onInit() {
    totalPref();
    gameTimePlay();
    super.onInit();
  }
}