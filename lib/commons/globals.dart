import 'package:flutter/material.dart';
import 'dart:math' as math;


class CardInfo {
  String text;

  CardInfo(this.text);
}


List<CardInfo> cardList = [
  CardInfo("Текст карточки 1"),
  CardInfo("Текст карточки 2"),
  CardInfo("Текст карточки 1"),
  CardInfo("Текст карточки 2"),
  CardInfo("Текст карточки 1"),
  CardInfo("Текст карточки 2"),
  CardInfo("Текст карточки 1"),
  CardInfo("Текст карточки 2"),

];


final appBorders = BorderRadius.circular(10);

var pageName = 'Новости';


// void gotoDetailsPage(BuildContext context) {
//   Navigator.of(context).push(PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return AnimatedBuilder(
//         animation: animation,
//         builder: (context, child) {
//           const double beginRadius = 0.0;
//           const double endRadius = 1.0;
//           var radiusTween = Tween(begin: beginRadius, end: endRadius);
//           var radius = radiusTween.evaluate(animation);
//
//           return ClipPath(
//             clipper: CircleRevealClipper(
//                 radius * math.sqrt(math.pow(MediaQuery
//                     .of(context)
//                     .size
//                     .width, 2) + math.pow(MediaQuery
//                     .of(context)
//                     .size
//                     .height, 2))),
//             child: child,
//           );
//         },
//         child: child,
//       );
//     },
//   ));
// }
//
// class DetailsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Details')),
//       body: Center(
//         child: Text('Details Screen', style: Theme.of(context).textTheme.headline4),
//       ),
//     );
//   }
// }
//
// class CircleRevealClipper extends CustomClipper<Path> {
//   final double radius;
//   CircleRevealClipper(this.radius);
//
//   @override
//   Path getClip(Size size) {
//     return Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius));
//   }
//
//   @override
//   bool shouldReclip(CircleRevealClipper oldClipper) => radius != oldClipper.radius;
// }
