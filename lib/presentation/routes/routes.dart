import 'package:flutter/material.dart';
import 'package:my_achievements/pages/login.dart';
import 'package:my_achievements/pages/searchPage.dart';
import 'package:my_achievements/pages/tourList.dart';

import '../../commons/globals.dart';
import '../../pages/account.dart';
import '../../templates/testPage.dart';



class PageRouter {
  PageRouter();

  Future<List<Widget>> get pages async {
    bool loggedIn = await AuthState.isLoggedIn();
    return [
      Center(child: TourList()),
      Center(child: SearchPage()),
      Center(child: MyFirebasePage()),
      Center(child: loggedIn ? ProfilePage() : LoginPage()),
    ];
  }

  Future<int> get length async => (await pages).length;
}
