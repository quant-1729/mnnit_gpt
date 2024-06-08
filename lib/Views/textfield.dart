import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/home.dart';
import 'package:mnnit_gpt/Views/chatroom.dart';
import 'package:mnnit_gpt/models/messagemodel.dart';
import 'package:mnnit_gpt/models/usermodel.dart';
import 'package:uuid/uuid.dart';
import 'package:mnnit_gpt/models/chat_room_model.dart';
import 'package:uuid/uuid.dart';
import '../utils/constants.dart';

class Textfield extends StatefulWidget {
  final UserModel userModel;
  const Textfield({super.key, required this.userModel});

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  @override
  int _selectedIndex = 0;
  TextEditingController textcontroller= TextEditingController();
  ChatRoomModel chatRoomModel= ChatRoomModel(chatroomid: Uuid.NAMESPACE_DNS, lastMessage: "Last msg");


  //Seding the textmessage to the firebase
  void sendmessage() {
    String message = textcontroller.text.toString().trim();
    if (message != "") {
      MessageModel messageModel = MessageModel(
          createdon: DateTime.now().toString(), messageid: Uuid.NAMESPACE_DNS, text:message);

      FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomModel.chatroomid).collection("messages").doc(messageModel.messageid).set(messageModel.tomap());
    }
  }
  // List of pages to navigate
  final List<Widget> _pages = [
   HomePage(),
    Chatroom()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Microphone_icon(20),
                        Spacer(),
                        Flexible(child: Textinput("Ask something...")),
                        Spacer(),
                        Sendicon(20)



                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
  Widget Microphone_icon(double radius){
    return GestureDetector(
      onLongPress: (){
        radius= radius+5;
      },
      child: CircleAvatar(
        backgroundColor: AppColors.Button_background,
        radius: radius,
        child: Center(
            child: Icon(Icons.mic, color: Colors.white,size: radius* 1.2, )

        ),
      ),
    );
  }
  Widget Textinput(String hint){
    return Container(
      child: TextField(
        controller: textcontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFF5F5F6))
          ),
          fillColor: Color(0xFFF5F5F6),
          filled: true,
          hintText: "Ask what's on mind...",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),

      ),
    );
  }
  Widget Sendicon (double radius){
    return GestureDetector(
      onTap: (){
        sendmessage();
      },
      child: CircleAvatar(
        backgroundColor: AppColors.Button_background,
        radius: radius,
        child: Center(
            child: Icon(CupertinoIcons.paperplane_fill, color: Colors.white,size: radius* 1.2, )

        ),
      ),
    );
  }
}
