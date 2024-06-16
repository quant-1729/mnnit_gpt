import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/intro_screen.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/home.dart';
import 'package:mnnit_gpt/models/user_model.dart';
import 'package:mnnit_gpt/Views/loading_screen.dart';
import 'package:mnnit_gpt/Views/home.dart';// Import the loading screen

class Wrapper extends StatelessWidget {
  Wrapper({super.key});
  UserModel userModel = UserModel();

  Future<void> UserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userModel.email = currentUser.email;
      userModel.uid = currentUser.uid;
      print(userModel.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen(); // Show loading screen while initializing
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error initializing Firebase'),
            ),
          );
        } else {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, authSnapshot) {
              if (authSnapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen(); // Show loading screen while checking auth state
              } else if (authSnapshot.hasData) {
                UserData();
                return HomePage(usermodel: userModel,);
              } else {
                return IntoScreen();
              }
            },
          );
        }
      },
    );
  }
}
