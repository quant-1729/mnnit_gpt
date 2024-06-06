import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/sign_up.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/home.dart';
import 'package:mnnit_gpt/Views/intro_screen.dart';

class routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
     '/SignUpPage':(context) => SignUp(),
      '/LoginPage':(context) => LoginScreen(),


    };
  }
}
