import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/intro_screen.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/home.dart';
 class Wrapper extends StatelessWidget {
   const Wrapper({super.key});

   @override
   Widget build(BuildContext context) {
     return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
       if(snapshot.hasData){
         return HomePage();
       }
       else{
         return LoginScreen();
       }
     });
   }
 }
