import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/transactions/transaction_db.dart';
import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

ValueNotifier<List<TransactionModel>> allNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeAllNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expenseAllNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> todayNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> yesterdayNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeTodayNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeYesterdayNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expenseTodayNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expenseYesterdayNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> lastWeekNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeLastWeekNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expenseLastWeekNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> lastMonthNotifier = ValueNotifier([]);
ValueNotifier<List<TransactionModel>> incomeLastMonthNotifier =
    ValueNotifier([]);
ValueNotifier<List<TransactionModel>> expenseLastMonthNotifier =
    ValueNotifier([]);

String today = DateFormat.yMd().format(
  DateTime.now(),
);
String yesterday = DateFormat.yMd().format(
  DateTime.now().subtract(
    const Duration(days: 1),
  ),
);

filterFunction() async {
  final list = await TransactionDB.instance.accessTransactions();
  List<TransactionModel> allList = [];
  List<TransactionModel> incomeList = [];
  List<TransactionModel> expenseList = [];
  List<TransactionModel> todayList = [];
  List<TransactionModel> yesterdayList = [];
  List<TransactionModel> incomeTodayList = [];
  List<TransactionModel> incomeYesterdayList = [];
  List<TransactionModel> expenseTodayList = [];
  List<TransactionModel> expenseYesterdayList = [];
  List<TransactionModel> lastWeekList = [];
  List<TransactionModel> incomeLastWeekList = [];
  List<TransactionModel> expenseLastWeekList = [];
  List<TransactionModel> lastMonthList = [];
  List<TransactionModel> incomeLastMonthList = [];
  List<TransactionModel> expenseLastMonthList = [];

  for (var element in list) {
    if (element.category.type == CategoryType.income) {
      incomeList.add(element);
    } else if (element.category.type == CategoryType.expense) {
      expenseList.add(element);
    }
    allList.add(element);
  }

  for (var element in list) {
    String elementDate = DateFormat.yMd().format(element.date);
    if (elementDate == today) {
      todayList.add(element);
    } else if (elementDate == yesterday) {
      yesterdayList.add(element);
    }
    if (element.date.isAfter(
      DateTime.now().subtract(
        const Duration(days: 7),
      ),
    )) {
      lastWeekList.add(element);
    }
    if (element.date.isAfter(
      DateTime.now().subtract(
        const Duration(days: 30),
      ),
      // selectedGrapMonth
    )) {
      lastMonthList.add(element);
    }

    if (elementDate == today && element.type == CategoryType.income) {
      incomeTodayList.add(element);
    } else if (elementDate == yesterday &&
        element.type == CategoryType.income) {
      incomeYesterdayList.add(element);
    } else if (elementDate == today && element.type == CategoryType.expense) {
      expenseTodayList.add(element);
    } else if (elementDate == yesterday &&
        element.type == CategoryType.expense) {
      expenseYesterdayList.add(element);
    }
    if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ) &&
        element.type == CategoryType.income) {
      incomeLastWeekList.add(element);
    } else if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ) &&
        element.type == CategoryType.expense) {
      expenseLastWeekList.add(element);
    } else if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ) &&
        element.type == CategoryType.income) {
      incomeLastMonthList.add(element);
    } else if (element.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 30),
          ),
        ) &&
        element.type == CategoryType.expense) {
      expenseLastMonthList.add(element);
    }
  }

  // Update ValueNotifier lists with the filtered data
  allNotifier.value = allList;
  incomeAllNotifier.value = incomeList;
  expenseAllNotifier.value = expenseList;
  todayNotifier.value = todayList;
  yesterdayNotifier.value = yesterdayList;
  incomeTodayNotifier.value = incomeTodayList;
  incomeYesterdayNotifier.value = incomeYesterdayList;
  expenseTodayNotifier.value = expenseTodayList;
  expenseYesterdayNotifier.value = expenseYesterdayList;
  lastWeekNotifier.value = lastWeekList;
  incomeLastWeekNotifier.value = incomeLastWeekList;
  expenseLastWeekNotifier.value = expenseLastWeekList;
  lastMonthNotifier.value = lastMonthList;
  incomeLastMonthNotifier.value = incomeLastMonthList;
  expenseLastMonthNotifier.value = expenseLastMonthList;
}
