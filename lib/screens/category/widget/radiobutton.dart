import 'package:flutter/material.dart';
import '../../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder<CategoryType>(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType currentCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: currentCategory,
              onChanged: (value) {
                if (value != null) {
                  selectedCategoryNotifier.value = value;
                }
              },
            );
          },
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
