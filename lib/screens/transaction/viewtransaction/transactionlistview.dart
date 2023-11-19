// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../../db/transactions/transaction_db.dart';
import '../../../../models/category/category_model.dart';
import '../../../../models/transaction/transaction_model.dart';
import '../edit_transaction/edit_transaction.dart';
import 'view_transaction.dart';

late var dropDownVale;

class TransationListView extends StatefulWidget {
  final List<TransactionModel> results;
  const TransationListView({
    Key? key,
    required this.results,
  }) : super(key: key);
  @override
  State<TransationListView> createState() => _DropdownListState();
}

class _DropdownListState extends State<TransationListView> {
  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  String dropdownvalue = 'All';
  var items = [
    'All',
    'income',
    'Expense',
  ];

  @override
  Widget build(BuildContext context) {
    log(widget.results.length.toString());
    return Material(
        color: Colors.lightGreen,
        child: widget.results.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final value = widget.results[index];
                  log(value.id.toString(), name: 'value check');
                  return GestureDetector(
                    onTap: () {
                      log(value.id.toString(), name: 'gesture');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => View_Transaction(
                                    amount: value.amount,
                                    category: value.category.name,
                                    description: value.purpose,
                                    date: value.date,
                                  )));
                    },
                    child: Slidable(
                      startActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(20),
                          spacing: 8,
                          backgroundColor: Colors.lightGreen,
                          foregroundColor: Colors.black,
                          icon: IconlyLight.edit,
                          label: 'Edit',
                          onPressed: (context) {
                            final model = TransactionModel(
                                purpose: value.purpose,
                                amount: value.amount,
                                date: value.date,
                                category: value.category,
                                type: value.type,
                                id: value.id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditTransaction(
                                          model: model,
                                        )));
                          },
                        ),
                        SlidableAction(
                            borderRadius: BorderRadius.circular(20),
                            spacing: 8,
                            backgroundColor: Colors.lightGreen,
                            foregroundColor: Colors.red,
                            icon: IconlyLight.delete,
                            label: 'Delete',
                            onPressed: (context) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete'),
                                      content: const Text(
                                          'Do you want to delete this transaction?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              TransactionDB.instance
                                                  .deleteTransaction(value.id!);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    );
                                  });
                            })
                      ]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.limeAccent[700],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.limeAccent[700],
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              leading: Text(
                                parseDate(value.date),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              trailing: Column(
                                children: [
                                  Text(
                                    ' ${value.category.name}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: value.type == CategoryType.income
                                          ? Colors.green[900]
                                          : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${value.amount}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: value.type == CategoryType.income
                                          ? Colors.green[900]
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 11,
                  );
                },
                itemCount: widget.results.length,
              )
            : Center(
                child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Lottie.asset('images/rubicscube.json')),
              ));
  }
}
