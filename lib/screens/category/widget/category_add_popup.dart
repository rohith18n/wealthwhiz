import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wealthwhiz/Screens/category/widget/radiobutton.dart';
import 'package:wealthwhiz/db/category/category_db.dart';
import 'package:wealthwhiz/models/category/category_model.dart';

Future<void> showCategoryAddPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Center(
          child: Text(
            'Add Category',
            style: TextStyle(color: Colors.black),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                final name = nameEditingController.text;
                final check =
                    selectedCategoryNotifier.value == CategoryType.income
                        ? CategoryDB.instance.incomeCategoryListListener.value
                            .where((element) => element.name.contains(name))
                        : CategoryDB.instance.expenseCategoryListListener.value
                            .where((element) => element.name.contains(name));
                log(check.toString());
                if (check.isNotEmpty) {
                  return;
                }
                if (name.isEmpty) {
                  return;
                }

                final type = selectedCategoryNotifier.value;
                final category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    type: type);

                CategoryDB.instance.insertCategory(category);
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
          )
        ],
      );
    },
  );
}
