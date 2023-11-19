import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                color: Colors.limeAccent[700]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'Greetings and welcome to our financial management application. Your utilization of our application is subject to the following terms and conditions. By using our application, you acknowledge and agree to abide by these terms and conditions. If you do not consent to these terms and conditions, kindly refrain from using our application.',
                      style: GoogleFonts.amiko(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'To use this application, you  are responsible for providing accurate and complete information\nNotify us immediately if you suspect any unauthorized use of your account.',
                      style: GoogleFonts.amiko(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'You bear sole responsibility for any content you upload or post on our application. You agree not to upload any content that is unlawful, defamatory, harassing, or objectionable in any way. We retain the right to remove any content that breaches these terms and conditions.',
                      style: GoogleFonts.amiko(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      " The Money Management App allows users to create custom categories for their transactions.\n Users agree to input accurate and truthful transaction details.\nThe app reserves the right to categorize or re-categorize transactions based on user input.\n\nThe WealthWhiz application utilizes third party service for data storage,Third-party packages are integrated for specific functionalities.\nUsers acknowledge and agree to the terms and conditions of the database provider and third-party packages.\n\n The Money Management App values user privacy. Please refer to the app's privacy policy for details on how user information is collected, used, and protected.\n\n We reserve the right to modify these terms and conditions at any time. Users will be notified of significant changes.\nWe reserve the right to terminate or suspend access to the Money Management App for any user violating these terms and conditions.\nIf you have any questions or concerns regarding these terms and conditions, please contact us at rohith18n@email.com",
                      style: GoogleFonts.amiko(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'By using the Money Management App, you signify your acceptance of these terms and conditions. Our application is intended for personal use only. You may not use our application for any commercial purpose or in a way that violates any laws or regulations.',
                      style: GoogleFonts.amiko(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
