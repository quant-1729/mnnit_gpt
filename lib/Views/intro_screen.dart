import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Views/sign_up.dart';
import 'package:mnnit_gpt/utils/constants.dart';
import 'package:mnnit_gpt/Widgets/First_button.dart';
import 'package:mnnit_gpt/Widgets/simple_button.dart';

class IntoScreen extends StatelessWidget {
  const IntoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assests/chat_bot_assistant_icon.png', width: 24,height: 24,), // Replace with actual image icon
        ),
        title: Text('Mnnit GPT', style: TextStyle(
            color: AppColors.text_color,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700


        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Leave Your \nVoice Instantly',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No login required for get started chat '
                      'with our AI powered chatbot. \n'
                      'Feel free to ask what you want to know.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xFF9449FE),Color(0xFF51A1FE),Color(0xFF955CFF)]
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(2.4),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.Button_background,
                  child: Center(
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(CupertinoIcons.mic, color: Colors.white,),
                      onPressed: () {
                        // Add action here
                      },
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  FirstButton(
                    text: 'Continue with Google',
                    backroundcolor: AppColors.Button_background,
                    textcolor: Colors.white,
                    height: 60,
                    onPressed: () {
                      },
                    borderradius: 10,
                    image: Image.asset('assests/google.png'),
                    circle_avatar_Color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  FirstButton(
                    text: 'Sign Up With Email',
                    backroundcolor: Color(0xFFEEEEFF),
                    textcolor: AppColors.Button_background,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUp()
                        ),
                      );
                    },
                    borderradius: 10,
                    image: Image.asset('assests/gmail.png'),
                    circle_avatar_Color: Color(0xFFEEEEFF),
                  ),
                  SizedBox(height: 10),
                  SimpleButton(
                    text: 'Login to Existing Account',
                    backroundcolor: Colors.white,
                    textcolor: AppColors.Button_background,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()
                        ),
                      );

                    },
                    borderradius: 10,
                    border_color: AppColors.Button_background,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
