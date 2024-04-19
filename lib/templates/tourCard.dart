import 'package:flutter/material.dart';
import '../commons/globals.dart';

class TourCard extends StatelessWidget {
  final String imagePath;
  final String text;

  const TourCard({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: cardBorders,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 15),
            child: SizedBox(
              height: 130,
              child: ClipRRect(
                borderRadius: cardBorders,
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 130,
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
