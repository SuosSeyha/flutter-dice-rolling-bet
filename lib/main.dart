import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_build_xocdia/page/dice_rolling_home.dart';
import 'package:flutter_build_xocdia/page/dice_rolling_splash.dart';
import 'package:flutter_build_xocdia/page/xocdia_gamepage.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  DiceRollingSplash(),
    );
  }
}
