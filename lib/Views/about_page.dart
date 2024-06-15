import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Define the URLs for your social media profiles
  final String linkedinUrl = 'https://www.linkedin.com/in/your-profile';
  final String githubUrl = 'https://github.com/your-profile';
  final String instagramUrl = 'https://www.instagram.com/your-profile';

  // Function to launch URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Color(0xFF1A1A4B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1: About the App
              Text(
                'About the App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A4B),
                ),
              ),
              SizedBox(height: 16),
              // Image and text side by side
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assests/chatbot_loading.gif', // Replace with your GIF path
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Mnnit-Gpt is your personal assistant designed to help you with daily tasks using advanced AI. Whether you need information, recommendations, or assistance with tasks, Mnnit-Gpt is here to provide seamless support.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A1A4B),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              // Section 2: Meet the Developer
              Text(
                'Meet the Developer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A4B),
                ),
              ),
              SizedBox(height: 16),
              // Circular Avatar and developer info
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assests/Priyanshu.jpeg'), // Replace with your photo path
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Priyanshu Agrawal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A4B),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.person, color: Color(0xFF5956FC), size: 30),
                          onPressed: () => _launchURL(linkedinUrl),
                        ),
                        SizedBox(width: 20),
                        // GitHub icon as text
                        GestureDetector(
                          onTap: () => _launchURL(githubUrl),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF5956FC),
                            ),
                            child: Text(
                              'GH',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.camera, color: Color(0xFF5956FC), size: 30),
                          onPressed: () => _launchURL(instagramUrl),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
