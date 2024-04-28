import 'package:flutter/material.dart';
import 'package:my_achievements/domain/requests/searchRequest.dart';

import '../domain/Preferences/SearchGlobals.dart';


class CustomSearchBar extends StatefulWidget {
  final ScrollController scrollController;
  final TextEditingController controller;
  final Function(String) onSearchSubmitted;

  CustomSearchBar({required this.scrollController, required this.onSearchSubmitted, required this.controller});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late double topPadding = 16.0;
  late double verticalPadding = 16.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    const double maxScrollExtent = 100.0; // Максимальное значение прокрутки для анимации
    double scrollOffset = widget.scrollController.offset;

    if (scrollOffset > maxScrollExtent) {
      scrollOffset = maxScrollExtent;
    }

    double newTopPadding = 16.0 * (1 - scrollOffset / maxScrollExtent);
    double newVerticalPadding = 20.0 * (1 - scrollOffset / maxScrollExtent);

    setState(() {
      topPadding = newTopPadding < 3 ? 3 : newTopPadding;
      verticalPadding = newVerticalPadding < 0 ? 0 : newVerticalPadding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(top: topPadding, right: 6, left: 6),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: AnimatedPadding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(46),
          child: Container(
            padding: EdgeInsets.all(verticalPadding),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF383E4D),
                  Color(0xFF262A34),
                  Color(0xFF262A34),
                  Color(0xFF383E4D),
                ],
                stops: [0.0, 0.2, 0.8, 1.0],
              ),
            ),
            child: TextField(
              controller: widget.controller,
              onSubmitted: widget.onSearchSubmitted,
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                contentPadding: EdgeInsets.all(18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.only(right: 16, left: 16, top: topPadding),
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(46),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF383E4D),
//                 Color(0xFF262A34),
//                 Color(0xFF262A34),
//                 Color(0xFF383E4D),
//               ],
//               stops: [0.0, 0.2, 0.8, 1.0],
//             ),
//           ),
//           child: TextField(
//             controller: widget.controller,
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               filled: true,
//               contentPadding: EdgeInsets.all(18),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//                 borderSide: BorderSide(color: Colors.transparent),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//                 borderSide: BorderSide(color: Colors.blue),
//               ),
//               suffixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
