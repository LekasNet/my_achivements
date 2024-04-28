import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_achievements/commons/globals.dart';
import 'package:my_achievements/commons/theme.dart';
import 'package:my_achievements/templates/decorations.dart';
import 'package:my_achievements/templates/tourCard.dart';

import '../domain/requests/newsRequest.dart';


class TourList extends StatefulWidget {
  @override
  _TourListState createState() => _TourListState();
}

class _TourListState extends State<TourList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Scaffold(
                  appBar: AppBar(
                    title: const Text("Новости"),
                    backgroundColor: AppTheme.darkThemeColors.background01,
                  ),
                  body: Stack(
                      children: [
                        StreamBuilder<List<DocumentSnapshot>>(
                          stream: getArticles(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Ошибка: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            var articles = snapshot.data ?? [];

                            return ListView.separated(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 16, right: 16, bottom: 16),
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                var article = articles[index];
                                return TourCard(
                                  imagePath: article['image'] as String,
                                  text: article['title'] as String,
                                  description: article['description'] as String,
                                  category: article['category'],
                                  date: article['pubdate'],
                                  tags: article['tag'],
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const Divider(
                                height: 20,
                                color: Colors.transparent,
                              ),
                            );
                          },
                        ),
                      ]
                  )
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(top: 3, right: 10),
                  width: 50,
                  height: 50,
                  child: AvatarButton(),
                ),
              )
            ]
        )
    );
  }
}