import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:my_achievements/templates/CustomSearchBar.dart';
import 'package:my_achievements/templates/tourCard.dart';

import '../domain/Preferences/SearchGlobals.dart';
import '../domain/requests/searchRequest.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  @override
  void initState() {
    super.initState();
    Globals.loadSearchQueries();
    _controller.addListener(_onSearchChanged);
    getDataFromFirestore();
  }

  void _onSearchChanged() {
    if (_controller.text.isEmpty) {
      setState(() {
        searchResults.clear();
      });
    } else {
      searchArticles(_controller.text).then((results) {
        setState(() {
          searchResults = results;
        });
        print(results);
      }).catchError((error) {
        // Обработка ошибки
      });
    }
  }

  void onSearchSubmitted(String query) {
    setState(() {
      Globals.loadSearchQueries();
    });
    if (query.isNotEmpty) {
      Globals.addSearchQuery(query);
    }
  }

  void onSearchQueryTap(String query) {
    setState(() {
      _controller.text = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(padding: EdgeInsets.only(top: 30),
          child: Scaffold(
            body: _controller.text.isNotEmpty ?
            ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                  top: 120, left: 16, right: 16, bottom: 16),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final doc = searchResults[index].data() as Map<String, dynamic>;
                return TourCard(
                  imagePath: doc['image'],
                  text: doc['title'],
                  description: doc['description'],
                  tags: const [],
                  category: doc['category'],
                  date: doc['pubdate'],
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 20,
                color: Colors.transparent,
              ),
            ) :
            ListView.builder(
              padding: const EdgeInsets.only(top: 120, left: 16, right: 16, bottom: 16),
              itemCount: Globals.searchQueries.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onSearchQueryTap(Globals.searchQueries[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Center(
                      child: Text(
                        Globals.searchQueries[index],
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                );
              },
            ),
          ),
          ),
          CustomSearchBar(
            scrollController: _scrollController,
            onSearchSubmitted: onSearchSubmitted,
            controller: _controller,
          ),
        ],
      )
    );
  }
}