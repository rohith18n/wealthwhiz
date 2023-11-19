import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../transaction/edit_transaction/edit_transaction.dart';
import '../transaction/viewtransaction/view_transaction.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // String _searchText = '';
  // List<String> _searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
        ),
        backgroundColor: Colors.lightGreen,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .063,
                width: MediaQuery.of(context).size.width * .75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusColor: Colors.lightGreen),
                  onChanged: (purpose) {
                    TransactionDB.instance.search(purpose);
                  },
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: TransactionDB.instance.transactionListNotifier,
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final value = newList[index];
                        return GestureDetector(
                          onTap: () {
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
                            startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
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
                                              builder: (context) =>
                                                  EditTransaction(
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
                                        value;

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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        TransactionDB.instance
                                                            .deleteTransaction(
                                                                value.id!);
                                                        Navigator.of(context)
                                                            .pop();
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
                                  // color: value.type == CategoryType.income
                                  //     ? Colors.white
                                  //     : Colors.white,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.limeAccent[700],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                            color: value.type ==
                                                    CategoryType.income
                                                ? Colors.green[900]
                                                : Colors.red,
                                          ),
                                        ),
                                        Text(
                                          "₹ ${value.amount}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: value.type ==
                                                    CategoryType.income
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
                          height: 10,
                        );
                      },
                      itemCount: newList.length,
                    ),
                  );
                }),
          ],
        ));
  }

  String parseDate(DateTime date) {
    final tempdate = DateFormat.MMMd().format(date);
    final splitedDate = tempdate.split(' ');
    return ' ${splitedDate.first} ${splitedDate.last}';
  }
}
