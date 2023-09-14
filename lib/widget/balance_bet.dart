import 'package:flutter/material.dart';
import 'game_text.dart';
class BalanceBet extends StatelessWidget {
//  final String text;
  final double amount;
  final String image;
  const BalanceBet({
    super.key,
   // required this.text,
    required this.amount,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // gameText(
        //   text: text,
        //   color: Colors.white, 
        //   fontSize: 30, 
        //   fontWeight: FontWeight.bold
        // ),
        Image.asset(
          image,
          height: 30,
          width: 30,
          fit: BoxFit.fill,
        ),
        gameText(
          text: "${amount.toString()}K",
          color: Colors.white, 
          fontSize: 30, 
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}