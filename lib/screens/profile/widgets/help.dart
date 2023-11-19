import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: const Text('Help',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ListTile(
                  title: Text('To Report a Problem',
                      style: GoogleFonts.amiko(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                      'Should you encounter any difficulties or have inquiries about our app, our dedicated support team is ready to assist you! You can contact us via email at rohith18n@gmail.com. Our team operates from Monday to Friday, 9 AM to 6 PM. \nWhen reporting a problem, please provide comprehensive details, including the steps to reproduce the issue and any error messages encountered. This information is crucial for us to investigate and resolve the problem efficiently. \nWe highly appreciate your feedback, and we are committed to continually enhancing our app. Your suggestions and comments are invaluable to us! Thank you for choosing and utilizing our app.',
                      style: GoogleFonts.amiko()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
