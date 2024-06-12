import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_room_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class ChatPage extends StatefulWidget {
  final ChatRoomModel chatroom;

  ChatPage({super.key, required this.chatroom});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "") {
      String messageId = Uuid().v4();

      MessageModel newMessage = MessageModel(
        messageid: messageId,
        createdon: DateTime.now(),
        text: msg,
      );

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      widget.chatroom.firstmessage = msg;
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroom.chatroomid)
          .set(widget.chatroom.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatrooms")
                    .doc(widget.chatroom.chatroomid)
                    .collection("messages")
                    .orderBy("createdon", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                      return ListView.builder(
                        reverse: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 2),
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  currentMessage.text,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("An error occurred! Please check your internet connection."),
                      );
                    } else {
                      return Center(
                        child: Text("Say hi to your new friend"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MicrophoneIcon(20),
                Spacer(),
                Flexible(child: TextInput("Ask something", messageController)),
                Spacer(),
                SendIcon(20, sendMessage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget MicrophoneIcon(double radius) {
  return GestureDetector(
    onLongPress: () {
      radius = radius + 5;
    },
    child: CircleAvatar(
      backgroundColor: AppColors.Button_background,
      radius: radius,
      child: Center(
        child: Icon(Icons.mic, color: Colors.white, size: radius * 1.2),
      ),
    ),
  );
}

Widget TextInput(String hint, TextEditingController controller) {
  return Container(
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFF5F5F6)),
        ),
        fillColor: Color(0xFFF5F5F6),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget SendIcon(double radius, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: AppColors.Button_background,
      radius: radius,
      child: Center(
        child: Icon(CupertinoIcons.paperplane_fill, color: Colors.white, size: radius * 1.2),
      ),
    ),
  );
}
