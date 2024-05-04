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
  final Set<String> _uniqueTags = {};
  final Set<String> _selectedTags = {};


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
                            _uniqueTags.clear(); // Очистка старых тегов

                            List<DocumentSnapshot> filteredArticles = [];
                            for (var article in articles) {
                              List<dynamic> tags = article['tag'] as List<dynamic>;
                              if (_selectedTags.isEmpty || tags.any((tag) => _selectedTags.contains(tag))) {
                                filteredArticles.add(article);
                              }
                              tags.forEach((tag) => _uniqueTags.add(tag as String));
                            }

                            return ListView.separated(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 16, right: 16, bottom: 16),
                              itemCount: filteredArticles.length,
                              itemBuilder: (context, index) {
                                var article = filteredArticles[index];
                                return TourCard(
                                  imagePath: article['image'] as String,
                                  text: article['title'] as String,
                                  description: article['description'] as String,
                                  category: article['category'],
                                  date: article['pubdate'],
                                  tags: article['tag'],
                                  onTagTap: (tag) {
                                    setState(() {
                                      _selectedTags.clear();
                                      _selectedTags.add(tag);
                                    });
                                  },
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 10),
                      child: IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () => _showFilterDialog(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 10),
                      width: 50,
                      height: 50,
                      child: AvatarButton(),
                    ),
                  ],
                ),
              )
            ]
        )
    );
  }
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Выберите теги для фильтрации"),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _uniqueTags.map((tag) => _buildSelectableTag(tag, context)).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Закрыть"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectableTag(String tag, BuildContext context) {
    return FilterChip(
      label: Text(tag),
      selected: _selectedTags.contains(tag),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedTags.add(tag);
          } else {
            _selectedTags.remove(tag);
          }
        });
        Navigator.of(context).pop();  // Закрыть диалог после выбора
      },
      backgroundColor: Colors.transparent,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.5),
      checkmarkColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Colors.green)),
    );
  }
}