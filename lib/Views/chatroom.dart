import 'package:flutter/material.dart';
import 'package:mnnit_gpt/models/messagemodel.dart';
import 'package:mnnit_gpt/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
