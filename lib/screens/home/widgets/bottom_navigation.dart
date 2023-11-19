import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'rootpage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: RootPage.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.lightGreen,
          animationDuration: const Duration(milliseconds: 600),
          height: 60,
          animationCurve: Curves.easeIn,
          index: updatedIndex,
          onTap: (newIndex) {
            RootPage.selectedIndexNotifier.value = newIndex;
          },
          items: const <Widget>[
            Icon(
              IconlyLight.home,
              size: 25,
            ),
            Icon(
              IconlyLight.chart,
              size: 25,
            ),
            Icon(
              IconlyLight.category,
              size: 25,
            ),
            Icon(
              IconlyLight.graph,
              size: 25,
            ),
          ],
        );
      },
    );
  }
}
