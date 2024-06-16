import 'package:flutter/material.dart';
import 'package:mnnit_gpt/utils/constants.dart';

class FirstButton extends StatelessWidget {
  final String text;
  final Color backroundcolor;
  final Color textcolor;
  final double height;
  final VoidCallback onPressed;
  final double borderradius;
  final Image image;
  final Color circle_avatar_Color;

  const FirstButton({
    required this.text,
    required this.backroundcolor,
    required this.textcolor,
    required this.height,
    required this.onPressed,
    required this.borderradius,
    required this.image,
    required this.circle_avatar_Color,




});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.Button_background),
          borderRadius: BorderRadius.all(Radius.circular(borderradius)),
          color: backroundcolor,

        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16,top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              CircleAvatar(
                backgroundColor: circle_avatar_Color,
                child: Center(
                    child: image),
              ),
              SizedBox(width: 20,),
              Center(
                child: Text(
                  text, style: TextStyle(
                  color: textcolor
                ),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
