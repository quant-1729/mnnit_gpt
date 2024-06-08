import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/intro_screen.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/home.dart';
import 'package:mnnit_gpt/Views/textfield.dart';
import 'package:mnnit_gpt/models/usermodel.dart';
 class Wrapper extends StatelessWidget {
   Wrapper({super.key});


   final UserModel userModel= UserModel(email: '', userid: '');
   Future<void> UserData() async{
     User? currentUser = FirebaseAuth.instance.currentUser;
     userModel.email= currentUser!.email;
     userModel.userid= currentUser!.uid;
     print(userModel.email);

   }

   @override
   Widget build(BuildContext context) {
     return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
       if(snapshot.hasData){
         UserData();
         return Textfield(userModel: userModel);
       }
       else{
         return LoginScreen();
       }
     });
   }
 }
