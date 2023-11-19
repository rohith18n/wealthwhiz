// ignore_for_file: camel_case_types, file_names
import 'package:flutter/material.dart';
import '../../../db/category/category_db.dart';
import '../widget/category_add_popup.dart';
import '../widget/expense_category.dart';
import '../widget/income_category.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _Screen_CategoryState();
}

class _Screen_CategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightGreen,
          title: const Text(
            'Categories',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0),
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
          onPressed: () => showCategoryAddPopup(context),
          backgroundColor: Colors.limeAccent[700],
          child: const Icon(Icons.add),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(15.0)),
              child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: const Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(15.0)),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    )
                  ]),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCategory(),
              ExpenseCategory(),
            ],
          ))
        ],
      ),
    );
  }
}
