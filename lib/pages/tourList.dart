import 'package:flutter/material.dart';
import 'package:my_achievements/commons/globals.dart';
import 'package:my_achievements/templates/decorations.dart';
import 'package:my_achievements/templates/tourCard.dart';


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
            ),
            body: Stack(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.only(
                        top: 10, left: 16, right: 16, bottom: 16),
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
                  ),
                ]
            )
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 5, right: 10),
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