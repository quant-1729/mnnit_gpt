import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mnnit_gpt/Views/Settings/Settings_page.dart';
import 'package:mnnit_gpt/Views/Settings/about_page.dart';
import 'package:mnnit_gpt/models/chat_room_model.dart';
import 'package:mnnit_gpt/models/user_model.dart';
import 'package:mnnit_gpt/utils/constants.dart';
import 'package:mnnit_gpt/Widgets/simple_button.dart';
import 'package:mnnit_gpt/Views/drawer.dart';
import 'package:uuid/uuid.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  final UserModel usermodel;
  const HomePage({super.key, required this.usermodel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChatRoomModel chatRoomModel = ChatRoomModel();
  var uuid = Uuid();

  sendmessage(String first_message) async {
    // Creating a new uid for the chatroom
    String chat_room_id = uuid.v4();
    // Extracting the first message
    chatRoomModel.chatroomid = chat_room_id;
    chatRoomModel.firstmessage = first_message;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          userid: widget.usermodel.uid!,
          chatroom: chatRoomModel,
          first_message: first_message,
        ),
      ),
    );
  }

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            const Text(
              "Mnnit-Gpt",
              style: TextStyle(
                fontSize: 22,
                color: AppColors.text_color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
           IconButton(onPressed: (){
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => SettingsPage()
               ),
             );
           }, icon: Icon(Icons.info))
          ],
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Drawer_home(userModel: widget.usermodel),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image(
                        image: AssetImage('assests/Roboassistantgif.gif'),
                        width: 130,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Hello Boss!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.text_color,
                      ),
                    ),
                    Text(
                      "Am Ready to Help You",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.text_color,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Ask me anything what's no your mind ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.text_color,
                      ),
                    ),
                    Text(
                      "I am here to assist you!",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.text_color,
                      ),
                    ),
                    SizedBox(height: 40),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      physics: ScrollPhysics(),
                      child: Row(
                        children: [
                          HorizontalCard(
                            Colors.lightGreenAccent,
                            "Try",
                            " Tell me about robotics club",
                                () {
                              sendmessage("Tell me about robotics club");
                            },
                          ),
                          SizedBox(width: 10),
                          HorizontalCard(
                            AppColors.Button_background,
                            "Try ",
                            "Tell me about the Warden's office at MNNIT",
                                () {
                              sendmessage("Tell me about the Warden's office at MNNIT");
                            },
                          ),
                          SizedBox(width: 10),
                          HorizontalCard(
                            Colors.orange,
                            "Try ",
                            "Who is the director of Mnnit",
                                () {
                              sendmessage("Who is the director of Mnnit");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MicrophoneIcon(25),
                SizedBox(width: 8),
                Expanded(
                  child: TextInput("Ask something", messageController),
                ),
                SizedBox(width: 8),
                SendIcon(25, () {
                  sendmessage(messageController.text.toString().trim());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget HorizontalCard(Color iconColor, String title, String description, VoidCallback onpressed) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F6),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 230,
      height: 190,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconColor,
              child: Center(
                child: Text(
                  "{...}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: AppColors.text_color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 2),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.text_color,
                fontSize: 12,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(
                    text: "Get Answer",
                    backroundcolor: iconColor,
                    textcolor: Colors.white,
                    height: 30,
                    onPressed: onpressed,
                    borderradius: 10,
                    border_color: iconColor,
                  ),
                  Spacer(),
                  SimpleButton(
                    text: "Edit Prompt",
                    backroundcolor: Colors.white,
                    textcolor: iconColor,
                    height: 30,
                    onPressed: onpressed,
                    borderradius: 10,
                    border_color: iconColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MicrophoneIcon(double radius) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          radius = radius + 5;
        });
      },
      child: CircleAvatar(
        backgroundColor: AppColors.Button_background,
        radius: radius,
        child: Center(
          child: Icon(
            Icons.mic,
            color: Colors.white,
            size: radius * 1.2,
          ),
        ),
      ),
    );
  }

  Widget TextInput(String hint, TextEditingController messageController) {
    return Container(
      child: SizedBox(
        height: 48, // Set a fixed height here
        child: TextField(
          controller: messageController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFF5F5F6)),
            ),
            fillColor: Color(0xFFF5F5F6),
            filled: true,
            hintText: hint, // Use the provided hint parameter
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
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
          child: Icon(
            CupertinoIcons.paperplane_fill,
            color: Colors.white,
            size: radius * 1.2,
          ),
        ),
      ),
    );
  }
}