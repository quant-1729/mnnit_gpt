import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>  LoginPage(),
        ),
              (Route<dynamic> route) => false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80,),
          Center(
            child: Text(
              "Leaving us ??",style: TextStyle(
                fontSize: 18,
                color: AppColors.text_color
            ),
            ),
          ),
          Center(
            child: Image.asset('assests/Log_out.gif'),
          ),
          Center(child: Text("Par Mujhe to Data Mil Gaya", style: TextStyle(
            fontSize: 18,
            color: AppColors.text_color
          ),),)
        ],
      ),
    );
  }
}

