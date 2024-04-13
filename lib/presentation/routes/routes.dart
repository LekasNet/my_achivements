import 'package:flutter/material.dart';
import 'package:my_achivements/pages/tourList.dart';



class PageRouter {
  PageRouter();

  List<Widget> get pages => [
    Center(child: TourList()),
    Center(child: Text('Likes')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];

  int get lenght => pages.length;

  // тут будут особенности страниц и провайдеры

}