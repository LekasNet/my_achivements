import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_achievements/commons/theme.dart';
import '../commons/globals.dart';
import 'package:my_achievements/templates/tourPopUpMenu.dart';
import 'package:intl/intl.dart';


class TourCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final String description;
  final String category;
  final Timestamp date;
  final List<dynamic> tags;
  final Function(String) onTagTap;

  const TourCard({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.description,
    required this.category,
    required this.date,
    required this.tags,
    required this.onTagTap,
  }) : super(key: key);

  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('d MMM yyyy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = formatTimestamp(date);
    return GestureDetector(
        onTap: () {
          tourPopupMenu(context, imagePath, text, description, category);
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 300,
          ),
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: const Color(0xFF252a32),
              borderRadius: cardBorders * 2,
              border: category == 'Tournaments' ? Border.all(width: 2, color: Colors.red) : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 180,
                          child: ClipRRect(
                            borderRadius: cardBorders,
                            child: Image.network(
                              imagePath,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 14),
                          child: Text(
                            text,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow
                                .ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkThemeColors.secondary,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                              children: tags.map((tag) => _buildTag(tag as String, context)).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
        )
    );
  }
  Widget _buildTag(String tag, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTagTap(tag);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xFF9EF3A4), width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          tag.toLowerCase(),
          style: const TextStyle(
            color: Color(0xFF9EF3A4),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
