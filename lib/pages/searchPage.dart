import 'package:flutter/material.dart';
import 'package:my_achievements/commons/globals.dart';
import 'package:my_achievements/templates/CustomSearchBar.dart';
import 'package:my_achievements/templates/decorations.dart';
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

  @override
  void initState() {
    super.initState();
    Globals.loadSearchQueries();
    _controller.addListener(_onSearchChanged);
    getDataFromFirestore();
  }

  void _onSearchChanged() {
    SearchingQuery(_controller.text);
    setState(() {});
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
      _controller.text = query; // Вставка текста в поле поиска
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(padding: EdgeInsets.only(top: 30),
          child:Scaffold(
            body: _controller.text.isNotEmpty ?
            ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                  top: 120, left: 16, right: 16, bottom: 16),
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                return TourCard(
                  imagePath: 'assets/image.jpg',
                  text: cardList[index].text,
                );
              },
              separatorBuilder: (context, index) =>
              const Divider(
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Center(
                      child: Text(
                        Globals.searchQueries[index],
                        style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ),
                );
              },
            ),
          ),
          ),
          CustomSearchBar(scrollController: _scrollController, onSearchSubmitted: onSearchSubmitted, controller: _controller,),
        ],
      )
    );
  }
}