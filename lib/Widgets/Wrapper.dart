import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/intro_screen.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/home.dart';
import 'package:mnnit_gpt/models/user_model.dart';
 class Wrapper extends StatelessWidget {
   Wrapper({super.key});

   UserModel userModel= UserModel();
   Future<void> UserData() async{
     WidgetsFlutterBinding.ensureInitialized();
     Firebase.initializeApp();
     User? currentUser = FirebaseAuth.instance.currentUser;
     userModel.email= currentUser!.email;
     userModel.uid= currentUser!.uid;
     print(userModel.email);

   }

   @override
   Widget build(BuildContext context) {
     return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snapshot){
       if(snapshot.hasData){
         UserData();
         return HomePage();
       }
       else{
         return LoginScreen();
       }
     });
   }
 }
