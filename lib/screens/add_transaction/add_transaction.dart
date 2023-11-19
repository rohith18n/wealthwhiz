import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../db/category/category_db.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/rootpage.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategorytype;
  CategoryModel? selectedCategoryModel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    CategoryDB.instance.refreshUI();
    selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text(
            'New Transaction',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.limeAccent[700],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: _purposeTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.white,
                    labelText: 'Description',
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.limeAccent[700],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    labelText: 'amount',
                    hintText: 'amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.limeAccent[700],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Colors.black,
                        ),
                  ),
                  child: TextButton.icon(
                    onPressed: () async {
                      final selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 60)),
                        lastDate: DateTime.now(),
                      );

                      if (selectedDateTemp == null) {
                        return;
                      } else {
                        setState(() {
                          selectedDate = selectedDateTemp;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    label: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : DateFormat("dd-MMM-yyyy").format(selectedDate!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.limeAccent[700],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: selectedCategorytype,
                            activeColor: Colors.black,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategorytype = CategoryType.income;
                                _categoryID = null;
                              });
                            }),
                        const Text(
                          'Income',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.limeAccent[700],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Radio(
                            value: CategoryType.expense,
                            groupValue: selectedCategorytype,
                            activeColor: Colors.black,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategorytype = CategoryType.expense;
                                _categoryID = null;
                              });
                            }),
                        const Text(
                          'Expense',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Container(
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: Colors.limeAccent[700],
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: DropdownButton<String>(
                    underline: Container(),
                    borderRadius: BorderRadius.circular(15),
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(color: Colors.black),
                    ),
                    value: _categoryID,
                    items: (selectedCategorytype == CategoryType.income
                            ? CategoryDB().incomeCategoryListListener
                            : CategoryDB().expenseCategoryListListener)
                        .value
                        .map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        _categoryID = selectedValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: const Size(150, 45),
                  ),
                  onPressed: () {
                    addTransaction();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  Future<void> addTransaction() async {
    final purposeText = _purposeTextEditingController.text.trim();
    final amountText = _amountTextEditingController.text.trim();
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (selectedDate == null) {
      return;
    }

    if (selectedCategoryModel == null) {
      return;
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
        purpose: purposeText,
        amount: parsedAmount,
        date: selectedDate!,
        type: selectedCategorytype!,
        category: selectedCategoryModel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    await TransactionDB.instance.addTransaction(model);
    RootPage.selectedIndexNotifier.value = 1;
    TransactionDB.instance.refreshAll();
  }
}
