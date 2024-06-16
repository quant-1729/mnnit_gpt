import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Center(
                 child:  Text(
                    'Introduction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A4B),
                    ),
                  )
              ),
              SizedBox(height: 10,),

              // GIF at the top
              Center(
                child: Image.asset(
                  'assests/Roboassistantgif.gif', // Replace with your GIF path
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 16),
              // Introduction Text
              Text(
                'Mnnit-Gpt is a Chat-Bot assistant designed to help you provide basic information about our college. Whether you need information, recommendations, or assistance with tasks, Mnnit-Gpt is here to provide seamless support.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1A1A4B),
                ),
              ),
              SizedBox(height: 16),
              // Features Section
              Center(
                child: Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A4B),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assests/chatbot_loading.gif', // Replace with your image path
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '1. NLU-based chatbot learning\n2. Flutter UI \n3. Database storage of user information\n4. Storage of chat history with the bot\n5. Human-like Personna',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A1A4B),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Tech Stack Section
              Center(
                child: Text(
                  'Tech Stack Used',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A4B),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Dart is used to build the UI and provide a high-end User Experience; the high-performance backend is created to make the models and perform the operation. The frameworks used in the chatbot are Flutter and Rasa AI. Firebase is used for services like authentication and database storage. The Rasa server can be hosted locally or Globally to get the response to the queries.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A1A4B),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Image.asset(
                      'assests/chat_for_about_2.gif', // Replace with your image path
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Contributors Section
              Center(
                child: Text(
                  'Contributors',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A4B),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assests/tiny-young-people-working-in-a-team-1.gif', // Replace with your image path
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'The AI model is built under the guidance of the Robotics Club and under the mentorship of Bhanu Pratap Singh and Sarthak Kumar, along with the team. However, the Flutter Framework is solely implemented by the Developer.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A1A4B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
