import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../db/category/category_db.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../home/widgets/rootpage.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction({super.key, required this.model});
  final TransactionModel model;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategorytype;
  CategoryModel? selectedCategoryModel;
  String? categoryID;

  final formkey = GlobalKey<FormState>();
  final purposeTextEditingController = TextEditingController();
  final amountTextEditingController = TextEditingController();

  @override
  void initState() {
    purposeTextEditingController.text = widget.model.purpose;
    amountTextEditingController.text = widget.model.amount.toString();
    selectedDate = widget.model.date;
    selectedCategorytype = widget.model.type;
    selectedCategoryModel = widget.model.category;
    log(widget.model.id.toString(), name: 'idcheck_init');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.model.id.toString(), name: 'buildcon');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text(
            'Edit Transaction',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.lightGreen),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        controller: purposeTextEditingController,
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
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: amountTextEditingController,
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
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.065,
                        width: MediaQuery.of(context).size.width * 0.85,
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
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 60)),
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
                                  : DateFormat("dd-MMMM-yyyy")
                                      .format(selectedDate!),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                                      selectedCategorytype =
                                          CategoryType.income;
                                      categoryID = null;
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
                          width: 40,
                        ),
                        Container(
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
                                  value: CategoryType.expense,
                                  groupValue: selectedCategorytype,
                                  activeColor: Colors.black,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategorytype =
                                          CategoryType.expense;
                                      categoryID = null;
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
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.065,
                        width: MediaQuery.of(context).size.width * 0.55,
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
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(),
                            hint: selectedCategoryModel != null
                                ? Text(
                                    selectedCategoryModel!.name,
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : const Text(
                                    'Select Category',
                                    style: TextStyle(color: Colors.black),
                                  ),
                            value: categoryID,
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
                                categoryID = selectedValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white,
                          fixedSize: const Size(170, 50),
                        ),
                        onPressed: () {
                          log(widget.model.id.toString(), name: 'onpress');
                          editTransaction();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }

  Future<void> editTransaction() async {
    final purposeText = purposeTextEditingController.text.trim();
    final amountText = amountTextEditingController.text.trim();
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (categoryID == null) {
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
    log(widget.model.id.toString(), name: 'hjuikjnj');

    final model = TransactionModel(
        purpose: purposeText,
        amount: parsedAmount,
        date: selectedDate!,
        type: selectedCategorytype!,
        category: selectedCategoryModel!,
        id: widget.model.id);

    await TransactionDB.instance.editTransaction(model);
    RootPage.selectedIndexNotifier.value = 1;
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    TransactionDB.instance.refreshAll();
  }
}
