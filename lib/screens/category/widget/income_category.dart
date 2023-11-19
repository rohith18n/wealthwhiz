import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        if (newList.isEmpty) {
          // Show a message when the income list is empty
          return Center(
            child: SizedBox(
                height: 250,
                width: 250,
                child: Lottie.asset('images/rubicscube.json')),
          );
        } else {
          // Show the ListView when there are income categories
          return ListView.separated(
            itemBuilder: (context, index) {
              final category = newList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(category.name),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                  'Do you want to delete this item?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      CategoryDB.instance
                                          .deleteCategory(category.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          IconlyLight.delete,
                          color: Colors.red,
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
          );
        }
      },
    );
  }
}
