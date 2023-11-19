import 'package:flutter/material.dart';
import '../../category/view/screen _category.dart';
import '../home.dart';
import '../../statistics/Statistics.dart';
import '../../transaction/viewtransaction/list_transaction.dart';
import 'bottom_navigation.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const HomePage(),
    const ScreenTransaction(),
    const ScreenCategory(),
    const StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, Widget? _) {
                return _pages[updatedIndex];
              })),
    );
  }
}
