import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mnnit_gpt/models/chat_room_model.dart';
import 'package:mnnit_gpt/utils/constants.dart';

class Drawer_home extends StatefulWidget {
  const Drawer_home({super.key});

  @override
  State<Drawer_home> createState() => _Drawer_homeState();
}

class _Drawer_homeState extends State<Drawer_home> {
  TextEditingController serch_controller= TextEditingController();
  List<ChatRoomModel> chatRooms = [];
  List<ChatRoomModel> filteredChatRooms = [];

  @override
  void initState() {
    super.initState();
    fetchChatRooms();
  }

  // Fetching the chatrooms for search
  void fetchChatRooms() async {
    FirebaseFirestore.instance
        .collection('chatrooms')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        chatRooms = snapshot.docs.map((doc) {
          return ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        filteredChatRooms = chatRooms;
      });
    });
  }

  // Filtering the fetched chatrooms based on the textfield input and the firstmessage
  void filterChatRooms(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredChatRooms = chatRooms;
      });
    } else {
      // Query Firestore for chat rooms where the first message starts with the search text
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('chatrooms')
          .where('firstmessage', isGreaterThanOrEqualTo: query)
          .where('firstmessage', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      setState(() {
        filteredChatRooms = snapshot.docs.map((doc) {
          return ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    }
  }


  _Drawer_homeState();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: serch_controller,
            decoration: InputDecoration(
              hintText: "Search chat History",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search_rounded,
                  size: 22,
                  color: Colors.grey,
                ), onPressed: () {
                  filterChatRooms(serch_controller.text.toString());
              },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Image.asset(
                'assests/chat_bot_assistant_icon.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 20),
              Text(
                "Mnnit GPT",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Replace AppColors.text_color with Colors.black or your custom color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.language,
                size: 40,
              ),
              SizedBox(width: 20),
              Text(
                "Community",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Replace AppColors.text_color with Colors.black or your custom color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Divider(color: Colors.grey,),
          SizedBox(height: 6,),
          Text("Chat History"),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chatrooms').snapshots(),
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.active){
                  QuerySnapshot datasnapshot= snapshot.data as QuerySnapshot;
                  List<ChatRoomModel> chatrooms= datasnapshot.docs.map((doc){
                    return ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>);
                  }).toList();
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Adjust padding as needed
                    itemCount: chatrooms.length,
                    itemBuilder: (context, index){
                      ChatRoomModel chatroom = chatrooms[index];
                      return ListTile(
                        title: Text(chatroom.firstmessage.toString()),
                        onTap: (){
                          // Navigating to the chatpage
                        },
                      );
                    },
                  );


                }
                else if(snapshot.hasError){
                  return Center(
                    child: Text("An error occured!"),
                  );
                }
                else {
                  return Center(
                    child: Text("No conversation yet"),
                  );
                }
              },
            )
          )
        ],
      ),
    );
  }


}
