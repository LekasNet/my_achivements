import 'package:flutter/material.dart';
import 'package:my_achievements/presentation/routes/navigator.dart';
import 'package:my_achievements/presentation/routes/routes.dart';
import 'package:my_achievements/templates/customNavBar.dart';
import 'package:provider/provider.dart';


class MainParentBuilder extends StatelessWidget {
  static PageRouter router = PageRouter();
  const MainParentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(
      builder: (context, tabManager, child) {
        return Scaffold(
          body: IndexedStack(
            index: tabManager.currentIndex,
            children: router.pages,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}