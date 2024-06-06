import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mnnit_gpt/utils/constants.dart';

class Drawer_home extends StatefulWidget {
  const Drawer_home({super.key});

  @override
  State<Drawer_home> createState() => _Drawer_homeState();
}

class _Drawer_homeState extends State<Drawer_home> {


  _Drawer_homeState();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search chat History",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 22,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Image.asset(
                'assests/chat_bot_assistant_icon.jpg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 40),
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
                size: 20,
              ),
              SizedBox(width: 40),
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            physics: ScrollPhysics(),
            child: ListBody(
              children: <Widget>[
                ListTile(title: Text('Web Page Design - HTML/CSS')),
                ListTile(title: Text('AI Impact On UI/UX Design')),
                // Add more ListTiles for other list items
              ],
            ),


          )
        ],
      ),
    );
  }


}
