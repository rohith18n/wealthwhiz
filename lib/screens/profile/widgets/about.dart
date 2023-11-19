import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text('About',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        elevation: 0,
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
          child: Column(
            children: [
              const SizedBox(height: 65),
              Text(
                'WealthWhiz',
                style: GoogleFonts.chelseaMarket(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'WealthWhiz',
                          style: GoogleFonts.bungeeShade(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                      TextSpan(
                          text:
                              ' is a money management app designed to help you track your expenses, create budgets, and achieve your financial goals. With our easy-to-use interface and powerful tools, you can take control of your finances and make informed decisions about your money.',
                          style: GoogleFonts.mcLaren(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Created by Rohith N',
                  style: GoogleFonts.quando(
                      fontSize: 15,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/facebook.png',
                      height: 35,
                      width: 35,
                    ),
                    Image.asset(
                      'images/ins.png',
                      height: 35,
                      width: 35,
                    ),
                    Image.asset(
                      'images/google.png',
                      height: 35,
                      width: 35,
                    ),
                    Image.asset(
                      'images/twitter.png',
                      height: 35,
                      width: 35,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
