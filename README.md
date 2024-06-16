AI Chatbot for College Information
Table of Contents
Introduction
Features
Installation
Usage
Project Structure
Technologies Used
Contributions
Contact
Introduction
This application provides real-time responses to queries using an AI chatbot model designed to give information about a college. It supports saving chat history and includes additional features developed over time, aimed at enhancing user experience during interactions.

Features
Real-time responses to queries using NLP dataset
Storage of chat history in Firebase database accessible via the app's drawing room
Sign-in & Sign-up features
Embedded with various settings options
Installation
To install the application:

Download the APK file to your Android device.
Or clone the repository and open it in your preferred IDE for further development.
Usage
To use the app:

Sign in to the application if you're a returning user or sign up as a new user.
Alternatively, sign in using your Google account.
Navigate to the home page to ask questions or interact with the chatbot.
Access settings by clicking on the settings icon to log out or exit the application.
Project Structure
bash
Copy code
my_flutter_app/
├── android/
├── ios/
├── lib/
│   ├── models/
│   │   └── user.dart            # Model classes
│   ├── controllers/
│   │   └── user_controller.dart  # Controller classes
│   ├── views/
│   │   ├── home_view.dart       # View classes
│   │   └── profile_view.dart
│   ├── widgets/
│   │   ├── user_card.dart       # Reusable UI components
│   │   └── custom_button.dart
│   ├── services/
│   │   └── user_service.dart    # Services for data fetching, API calls, etc.
│   ├── utils/
│   │   └── constants.dart       # Constants used throughout the app
│   ├── main.dart                # Entry point of the app
├── test/
├── pubspec.yaml
└── ...
Technologies Used
Flutter for the UI development, using Dart programming language
Firebase for real-time chat application backend, data storage, and streaming of chats
Rasa AI framework for retrieving responses using NLP-based intents and entities, communicated via REST API
Firebase for authentication processes (sign-in & sign-up)
Contributions
Flutter UI and backend services developed by Priyanshu Agrawal.
Machine learning components developed under the guidance of the Robotics Club and mentorship of Sarthak Kumar in Vanu Pratap Singh.
Contact
For further inquiries or assistance:

Email: priyanshuagrawal1729@gmail.com
GitHub: github.com/quant-1729
Phone: 8755799544





