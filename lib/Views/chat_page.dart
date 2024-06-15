import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_room_model.dart';
import '../models/message_model.dart';
import '../utils/constants.dart';

class ChatPage extends StatefulWidget {
  final ChatRoomModel chatroom;
  final String first_message;

  ChatPage({super.key, required this.chatroom, required this.first_message});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.first_message.isNotEmpty) {
      sendMessage(widget.first_message);
    }
  }

  Future<void> sendMessage(String message) async {
    String msg = message;
    messageController.clear();

    if (msg.isNotEmpty) {
      // Send message to Firestore
      String messageId = Uuid().v4();
      MessageModel newMessage = MessageModel(
        sender: "user",
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

      // Send message to Rasa
      String rasaResponse = await sendToRasa(msg);
      if (rasaResponse.isNotEmpty) {
        // Add Rasa's response to Firestore
        String rasaMessageId = Uuid().v4();
        MessageModel rasaMessage = MessageModel(
          sender: "RASA",
          messageid: rasaMessageId,
          createdon: DateTime.now(),
          text: rasaResponse,
        );
        // Sending the reasa response to the firebase

        await FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(widget.chatroom.chatroomid)
            .collection("messages")
            .doc(rasaMessage.messageid)
            .set(rasaMessage.toMap());
      }
    }
  }

  Future<String> sendToRasa(String message) async {
    final url = Uri.parse('http://192.168.242.162:5005/webhooks/rest/webhook');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sender': widget.chatroom.chatroomid,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.isNotEmpty) {
        return responseBody[0]['text'];
      } else {
        return "No response from the server.";
      }
    } else {
      throw Exception('Failed to get response from Rasa');
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

                          return (currentMessage.sender=="RASA")? rasamessage(currentMessage.text, currentMessage.createdon.toString()):  usermessagecard(currentMessage.text, currentMessage.createdon
                              .toString());

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
                SendIcon(20,() => sendMessage(messageController.text.toString().trim())),
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

Widget usermessagecard(String message, String dateandtime) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.Button_background ?? Colors.blue, // Ensure a fallback color
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            dateandtime,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
Widget rasamessage(String message ,String dateandtime ){
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assests/chat_bot_assistant_icon.png', width: 40 , height:40,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                message, style: TextStyle(
                  color: AppColors.Button_background,
                  fontSize: 16
              ),
              ),
            ),
          ),
        ),
        Text(dateandtime, style: TextStyle(
            color: Colors.grey,
            fontSize: 8
        ),)
      ],
    ),
  );
}

