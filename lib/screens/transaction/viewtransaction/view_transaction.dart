// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class View_Transaction extends StatelessWidget {
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  const View_Transaction(
      {super.key,
      required this.amount,
      required this.category,
      required this.description,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
        ),
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.limeAccent[700]),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Details',
                      style: GoogleFonts.quando(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: ListTile(
                      leading: const Icon(
                        IconlyLight.paper_plus,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Notes :  $description',
                        style: GoogleFonts.headlandOne(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: ListTile(
                      leading: const Icon(
                        Icons.currency_rupee,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Amount :  $amount',
                        style: GoogleFonts.headlandOne(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: ListTile(
                      leading: const Icon(
                        IconlyLight.calendar,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Date :  ${parseDate(date)}',
                        style: GoogleFonts.headlandOne(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: ListTile(
                      leading: const Icon(
                        IconlyLight.category,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Category :  $category',
                        style: GoogleFonts.headlandOne(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String parseDate(DateTime date) {
    final tempDate = DateFormat.MMMMd().format(date);
    final splitedDate = tempDate.split(' ');
    return '${splitedDate.last} ${splitedDate.first}';
  }
}
