// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

const transactionDbName = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> accessTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transationAll = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);

    db.put(obj.id, obj);
    log(obj.id.toString(), name: 'add');
    refreshAll();
  }

  Future<void> refreshAll() async {
    final list = await accessTransactions();
    log(list.length.toString(), name: 'refresh_list');
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
    incomeListenable.value.clear();
    expenseListenable.value.clear();
    transationAll.value.clear();

    await Future.forEach(transactionListNotifier.value,
        (TransactionModel transaction) {
      if (transaction.category.type == CategoryType.income) {
        incomeListenable.value.add(transaction);
        log(incomeListenable.value.length.toString());
      } else if (transaction.category.type == CategoryType.expense) {
        expenseListenable.value.add(transaction);
      }
      transationAll.value.add(transaction);
    });
    transationAll.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> accessTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.delete(id);
    refreshAll();
  }

  Future<void> editTransaction(TransactionModel model) async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    await db.put(model.id, model);
    log(model.id.toString(), name: 'edit');
    refreshAll();
  }

  Future<void> search(String text) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>(transactionDbName);

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(transactionDB.values.where((element) =>
        element.purpose.contains(text) ||
        element.category.name.contains(text)));
    transactionListNotifier.notifyListeners();
  }
}
