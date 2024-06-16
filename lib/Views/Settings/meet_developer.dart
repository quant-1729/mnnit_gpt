import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetDeveloperPage extends StatelessWidget {
  const MeetDeveloperPage({super.key});

  // Define the URLs for your social media profiles
  final String linkedinUrl = 'https://www.linkedin.com/in/priyanshu-agrawal-b9197626a';
  final String githubUrl = 'https://github.com/quant-1729';
  final String instagramUrl = 'https://www.instagram.com/priyanshuagrawal1729/';

  // Function to launch URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    catch (e){
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet the Developer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Allows overflow for positioning
              alignment: Alignment.center,
              children: [
                // Background image
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assests/background.jpg'), // Replace with your background image path
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // Circular Avatar positioned partially over the background image
                Positioned(
                  bottom: -60, // Adjust this value to move the avatar up or down
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assests/Priyanshu.jpeg'), // Replace with your photo path
                    backgroundColor: Colors.white, // Add a white background for the circular avatar
                  ),
                ),
              ],
            ),
            SizedBox(height: 80), // Adjust this value to provide space below the avatar
            // Section: Meet the Developer
            // Developer name
            Text(
              'Priyanshu Agrawal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            SizedBox(height: 16),

            Text(
              'Connect with me',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            // Social media icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('assests/Linkedin.png', height: 80, width: 80),
                  onPressed: () => _launchURL(linkedinUrl),
                ),
                SizedBox(width: 10),
                // GitHub icon as text
                IconButton(
                  icon: Image.asset('assests/github.png', height: 90, width: 90),
                  onPressed: () => _launchURL(githubUrl),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Image.asset('assests/Instagram.png', height: 80, width: 80),
                  onPressed: () => _launchURL(instagramUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
