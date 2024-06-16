import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/Settings/about_page.dart';
import 'package:mnnit_gpt/Views/Settings/contact_us.dart';
import 'package:mnnit_gpt/Views/Settings/meet_developer.dart';
import 'package:mnnit_gpt/Views/splash_screen.dart';

import '../../utils/constants.dart';

class SettingsPage extends StatelessWidget {
  final String asset= 'assests/'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 22,
          color: AppColors.text_color,
          fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Adding padding around the ListView
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.0), // Adding space between the app bar and the first card
            _buildSettingCard(context,"info.png", Icons.info, 'About', () {
              // Navigating to the about page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutAppPage()
                ),
              );
            }, iconColor: Color(0xFF5956FC)),
            SizedBox(height: 16.0), // Adding space between cards
            _buildSettingCard(context,"developer.png", Icons.person, 'Meet the Developer', () {
              // Handle Meet the Developer tile tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MeetDeveloperPage()
                ),
              );
            }, iconColor: Color(0xFF5956FC)),
            SizedBox(height: 16.0), // Adding space between cards
            _buildSettingCard(context,"contact_us.png",Icons.mail, 'Contact Us', () {

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactUsPage()
                ),
              );

              // Handle Contact Us tile tap
              print('Contact Us tapped');
            }, iconColor: Color(0xFF5956FC)),
            SizedBox(height: 16.0), // Adding space between cards
            _buildSettingCard(context,"logout.png", Icons.exit_to_app, 'Logout', () {
              _showLogoutDialog(context);
              // Handle Logout tile tap
              print('Logout tapped');
            }, textColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(BuildContext context,String iconroute , IconData iconData, String text, VoidCallback onTap,
      {Color? iconColor, Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2.0, // Adding elevation for a card-like effect
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4), // Padding inside the ListTile
          leading: Image.asset(asset+iconroute),
          title: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Logout"),
            onPressed: () {
              // Add your logout logic here
              _signOut(context);// Close the dialog
              // You can also navigate the user to the login screen or perform other actions
            },
          ),
        ],
      );
    },
  );
}

void _signOut(BuildContext context) {
  FirebaseAuth.instance.signOut();
  User ?user = FirebaseAuth.instance.currentUser;
  //Navigating to the login page
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SplashScreen()
    ),
  );

}

