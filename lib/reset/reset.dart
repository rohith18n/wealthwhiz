import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import '../account/balance.dart';
import '../Screens/splash/splash.dart';
import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Reset',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: Colors.limeAccent[700]),
            child: Column(
              children: [
                const SizedBox(
                  height: 110,
                ),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: Lottie.asset('images/red delete reset.json'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'))),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                    'Do you want to reset the entire data'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        final transactionDb = await Hive
                                            .openBox<TransactionModel>(
                                                'transaction-db');
                                        final categoryDb =
                                            await Hive.openBox<CategoryModel>(
                                                'category_database');

                                        categoryDb.clear();
                                        transactionDb.clear();
                                        incomeNotifier = ValueNotifier(0);
                                        expenseNotifier = ValueNotifier(0);
                                        totalNotifier = ValueNotifier(0);

                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => const Splash(),
                                        ));
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            });
                      },
                      child: const Text('Reset'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
