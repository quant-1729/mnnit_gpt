import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final String text;
final Color backroundcolor;
final Color textcolor;
final double height;
final VoidCallback onPressed;
final double borderradius;
final Color border_color;

  const SimpleButton({
    required this.text,
    required this.backroundcolor,
    required this.textcolor,
    required this.height,
    required this.onPressed,
    required this.borderradius,
    required this.border_color,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border:Border.all(
            color: border_color,

          ),
          borderRadius: BorderRadius.all(Radius.circular(borderradius)),
          color: backroundcolor,

        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
