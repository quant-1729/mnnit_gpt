import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mnnit_gpt/utils/constants.dart';
import 'package:mnnit_gpt/Widgets/simple_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text("Mnnit-Gpt", style: TextStyle(
                fontSize: 18, color: AppColors.text_color,
              fontWeight: FontWeight.bold
            ),),
            Spacer(),
            SimpleButton(text: "Login", backroundcolor: AppColors.Button_background , textcolor: Colors.white, height: 18, onPressed: (){}, borderradius: 30, border_color: AppColors.Button_background)
          ],
        ),
      ),
      drawer: Drawer(

      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image(image: AssetImage(
                  'assests/Roboassistantgif.gif',
                ), width: 130,
                  height: 120,
                ),
              ),
              Center(
                child: Text("Hello Boss!", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.text_color
                ),),
              ),
              Center(
                child: Text("Am Ready to Help You", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.text_color
                ),),
              ),
              SizedBox(
                height: 4,
              ),
              Center(
                child: Text("Ask me anything what's no your mind ", style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text_color
                ),),
              ),
              Center(
                child: Text("I am here to assist you!", style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text_color
                ),),
              ),
              SizedBox(height: 4,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                physics: ScrollPhysics(),
                child: Row(
                  children: [
                    Horizaontalcard(AppColors.Button_background, "Try bug", " I'm going to make it short and succinct.I invested a lot of time in LinkedIn content marketing and it is generating results so far.If you have a B2B product on a tight budget this miniguide can give you some ideas.Pros: Requires zero can bring customers and puts you in always-on networking mode"),
                    SizedBox(width: 10,),
                    Horizaontalcard(Colors.lightGreenAccent, "Try bug", " I'm going to make it short and succinct.I invested a lot of time in LinkedIn content marketing and it is generating results so far.If you have a B2B product on a tight budget this miniguide can give you some ideas.Pros: Requires zero can bring customers and puts you in always-on networking mode"),
                    SizedBox(width: 10,),
                    Horizaontalcard(Colors.orange, "Try bug", " I'm going to make it short and succinct.I invested a lot of time in LinkedIn content marketing and it is generating results so far.If you have a B2B product on a tight budget this miniguide can give you some ideas.Pros: Requires zero can bring customers and puts you in always-on networking mode"),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Microphone_icon(20),
                    Spacer(),
                    Flexible(child: Textinput("Ask somethign")),
                    Spacer(),
                    Sendicon(20)



                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget Horizaontalcard(Color Iconcolor, String title, String description){
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F6),
        borderRadius: BorderRadius.circular(12)
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
              backgroundColor: Iconcolor,
              child: Center(
                child: Text("{...}", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),
              ),
            ),
            SizedBox(height: 6,),
            Text(title, style: TextStyle(
              color: AppColors.text_color,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),),
            SizedBox(height: 2,),
            Text(description,maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(
                color: AppColors.text_color,
                fontSize: 12
            ),),
            
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(text: "Get Answer", backroundcolor: Iconcolor, textcolor: Colors.white, height: 20, onPressed: (){}, borderradius: 10, border_color: Iconcolor),
                  Spacer(),
                  SimpleButton(text: "Edit Prompt", backroundcolor: Colors.white, textcolor: Iconcolor, height: 20, onPressed: (){}, borderradius: 10, border_color: Iconcolor),
                ],
              ),
            )

          ],

        ),
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
      onTap: (){},
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
