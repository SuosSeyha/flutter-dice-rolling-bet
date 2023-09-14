import 'package:flutter/material.dart';
import 'game_text.dart';
class Board extends StatelessWidget {
  //final Color color;
  final double height;
  final double width;
  final String number;
  final String pay;
  final bool isDiceShow;
  const Board({
    super.key,
   // required this.color,
    required this.height,
    required this.width,
    required this.number,
    required this.pay,
    required this.isDiceShow
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.3),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
         // color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 5,
            color: isDiceShow?Colors.orange:Colors.transparent
          ),
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/Number button.png"
            ),
            fit: BoxFit.fill
          )
        ),
        child: FittedBox(
          child: Column(
            children: [
              gameText(
                text: number,
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              gameText(
                text: pay,
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w100
              )
            ],
          ),
        ),
      ),
    );
  }
}