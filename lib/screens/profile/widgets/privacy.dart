import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: const Text('Privacy Policy',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        centerTitle: true,
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
                      'Welcome to the Privacy Policy for the Money Management App ("Wealth Whiz"). This Privacy Policy outlines how we collect, use, and safeguard your personal information when you use our App. Please read this Privacy Policy carefully to understand our practices regarding your data.',
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      "Information We Collect\n\nTransaction Information : \nWe collect information about your financial transactions, custom categories, and associated details.\n\nTechnical Information: \nWe may collect information about your device, including the type of device, operating system, and unique device identifiers.",
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'How We Use Your Information\n\nProviding Services: \nWe use your information to provide you with the services and features of the App, including custom categories and transaction details.\n\nCommunication: \nWe may use your information to communicate with you about the App, updates, and promotional offers.\n\n Improving Services: \nYour data helps us analyze and improve the functionality and user experience of the App.',
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      "Data Security\n\nWe implement industry-standard security measures to protect your data from unauthorized access, disclosure, or alteration.\n\nYour data's security is a priority for us, and we implement measures to safeguard it from unauthorized access, alteration, or disclosure.",
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      'Third-Party Integration\n\nThe App may utilize third-party packages and services. Users are subject to the terms and conditions of these third parties.\n\nThe use of a Hive database for data storage is governed by the terms and conditions of the Hive database provider.',
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      "Children's Privacy \n\nThe App is not intended for individuals under the age of 13. We do not knowingly collect or solicit personal information from children.",
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      "Changes to Privacy Policy \n\nWe may update this Privacy Policy to reflect changes in our practices. Users will be notified of significant changes.",
                      style: GoogleFonts.amiko()),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      "Contact Us \n\nIf you have any questions, concerns, or requests regarding your privacy or this Privacy Policy, please contact us at rohith18n@gmail.com.\nBy using the Money Management App, you agree to the terms outlined in this Privacy Policy.",
                      style: GoogleFonts.amiko()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
