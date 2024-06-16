import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  final String email = 'priyanshuagrawal1729@gmail.com';
  final String phone = '+91 8755799544';

  // Function to launch email
  void _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Contact&body=Hello', // Add subject and body if needed
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to launch phone dialer
  void _launchPhone(String phone) async {
    var url = 'tel:$phone';
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
        title: Text('Contact Us'),
        backgroundColor:Color(0xFFF5F5F5),
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // Set the background color here
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A4B),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or just want to get in touch, feel free to contact me through any of the methods below:',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1A1A4B),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset('assests/mail.png'),
              title: Text(
                email,
                style: TextStyle(color: Color(0xFF1A1A4B)),
              ),
              onTap: () => _launchEmail(email),
            ),
            Divider(),
            ListTile(
              leading: Image.asset('assests/call.png'),
              title: Text(
                phone,
                style: TextStyle(color: Color(0xFF1A1A4B)),
              ),
              onTap: () => _launchPhone(phone),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
