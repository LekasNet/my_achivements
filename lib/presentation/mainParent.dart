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
          body: FutureBuilder<List<Widget>>(
            future: router.pages,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return IndexedStack(
                  index: tabManager.currentIndex,
                  children: snapshot.data!,
                );
              } else {
                // Показываем индикатор загрузки, пока данные загружаются
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}
