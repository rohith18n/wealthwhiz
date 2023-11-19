// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, camel_case_types

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../add_transaction/add_transaction.dart';
import '../../search/search.dart';
import 'transactionlistview.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({super.key});

  @override
  State<ScreenTransaction> createState() => _Screen_TransactionState();
}

class _Screen_TransactionState extends State<ScreenTransaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  dynamic dropDownVale = 'All';
  @override
  void initState() {
    TransactionDB.instance.refreshAll();
    dropDownVale = 'All';

    results.notifyListeners();
    results.value = TransactionDB().transationAll.value;
    results.notifyListeners();
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      results.value = TransactionDB().transationAll.value;
      results.notifyListeners();
      setState(() {
        filter(dropDownVale);
      });
      results.notifyListeners();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime selectedmonth = DateTime.now();
  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedmonth,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (picked != null && picked != selectedmonth) {
      setState(() {
        selectedmonth = picked;
      });
    }
  }

  ValueNotifier<List<TransactionModel>> results = ValueNotifier([]);

  List items = ['All', 'today', 'yesterday', 'week', 'month'];

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshAll();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Transactions',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                },
                icon: const Icon(
                  IconlyLight.search,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.lightGreen,
        floatingActionButton: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            )
          ]),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTransaction()));
            },
            backgroundColor: Colors.limeAccent[700],
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: TransactionDB.instance.transationAll,
          builder: (context, value, child) => ValueListenableBuilder(
            valueListenable: results,
            builder: (context, value, child) => Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.65,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: DropdownButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    underline: Container(),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(15),
                    items: items.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(e),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue == 'month') {
                        _selectDate(context);
                      }
                      filter(newValue);
                    }),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.044,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    tabs: const [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: TabBarView(controller: _tabController, children: [
                TransationListView(
                  results: results.value,
                ),
                TransationListView(
                  results: results.value,
                ),
                TransationListView(
                  results: results.value,
                )
              ])),
            ]),
          ),
        ));
  }

  void filter(newValue) {
    log('filter');

    results.value = TransactionDB().transationAll.value;
    results.notifyListeners();
    setState(() {
      dropDownVale = newValue;
    });
    log(results.value.length.toString(), name: 'vvvvvn');
    log(dropDownVale.toString(), name: 'filter');
    final DateTime now = DateTime.now();
    if (dropDownVale == 'All') {
      setState(() {
        results.value = (_tabController.index == 0
            ? TransactionDB().transationAll.value
            : _tabController.index == 1
                ? TransactionDB().incomeListenable.value
                : TransactionDB().expenseListenable.value);
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'today') {
      setState(() {
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) => parseDate(element.date)
                .toLowerCase()
                .contains(parseDate(DateTime.now()).toLowerCase()))
            .toList();
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'yesterday') {
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 1);
        DateTime end = start.add(const Duration(days: 1));
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'week') {
      results.notifyListeners();
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 6);
        DateTime end = DateTime(start.year, start.month, start.day + 7);
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
    } else {
      setState(() {
        DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
        DateTime end = DateTime(start.year, start.month + 1, start.day);
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
    }
  }
}
