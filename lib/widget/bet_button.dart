import 'package:flutter/material.dart';
import 'game_text.dart';
class BetButton extends StatelessWidget {
  final String image;
  const BetButton({
    super.key,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(3),
      alignment: Alignment.center,
      height: width/2*0.2,
      width: width/2*0.2,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.5, 0.5),
            color: Colors.black,
            blurRadius: 2
          )
        ],
        image: DecorationImage(
          image: AssetImage(
            image
          )
        )
      ),
      
    );
  }
}