import 'package:flutter/material.dart';
import 'package:my_achievements/pages/login.dart';
import 'package:my_achievements/pages/searchPage.dart';
import 'package:my_achievements/pages/tourList.dart';

import '../../templates/testPage.dart';


class PageRouter {
  PageRouter();

  List<Widget> get pages => [
    Center(child: TourList()),
    Center(child: SearchPage()),
    Center(child: MyFirebasePage()),
    Center(child: LoginPage()),
  ];

  int get lenght => pages.length;

  // тут будут особенности страниц и провайдеры

}