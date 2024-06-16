
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Views/home.dart';
import '../models/user_model.dart';
import 'dart:developer';
UserModel userModel = UserModel();



Sign(BuildContext context ,String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    // Definging the usermodel
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userModel.email = currentUser.email;
      userModel.uid = currentUser.uid;
      print(userModel.email);
    }
    // Navigating to the home page

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(usermodel: userModel,)),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {


    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wrong Password.. "),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong, \n try with other mail id")));
    }
    }
  }


Sign_Up(String emailAddress, String password, BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    // Definging the usermodel
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userModel.email = currentUser.email;
      userModel.uid = currentUser.uid;
      print(userModel.email);
    }
    // Navigating to the home page
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("The account already exists for that email."),
        ),
      );
    }
  } catch (e) {
    print(e);
  }
}



Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    // The user canceled the sign-in
    throw Exception('Google sign-in was canceled');
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, get the UserCredential
  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  final user = userCredential.user;

  if (user != null) {
    // Create a UserModel instance
    final userModelGoogle = UserModel(
      uid: user.uid,
      email: user.email,
    );

    // Navigate to home page on successful Google sign-in
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(usermodel: userModelGoogle)),
    );

    // Return the UserCredential
    return userCredential;
  } else {
    // This shouldn't happen but in case user is null, throw an exception
    throw Exception(ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Unable to sign in.."),
      ),
    ));
  }
}