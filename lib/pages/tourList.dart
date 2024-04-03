import 'package:flutter/material.dart';
import 'package:my_achivements/commons/globals.dart';
import 'package:my_achivements/templates/customAppBar.dart';
import 'package:my_achivements/templates/decorations.dart';


class TourList extends StatefulWidget {
  @override
  _TourListState createState() => _TourListState();
}

class _TourListState extends State<TourList> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(top: 68, left: 16, right: 16, bottom: 16),
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: appBorders,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15),
                      child: SizedBox(
                        height: 130,
                        child: ClipRRect(
                          borderRadius: appBorders,
                          child: Image.asset(
                            'assets/image.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 130,
                      child: Text(cardList[index].text),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
          const Divider(
            height: 20,
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: 0,
          child: CustomTopBar(),
        )
      ]
    );
  }
}