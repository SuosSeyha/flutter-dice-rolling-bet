import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GameHelper{
  static const totalBalance="totalAmount";
  static const routePref="DiceRollingBetKeyRS";
  

  static Future<void> setTotalBalance({required int totalAmount})async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(totalBalance, totalAmount);
    debugPrint(' totalAmount : $totalAmount');
  }
  static Future<void> setPage({required bool game})async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(routePref, game);
  }


  static Future<int?> getTotalBalance()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(totalBalance);
  }
  static Future<bool?> getPage()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(routePref);
  }
}