import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_achivements/commons/theme.dart';


class AvatarButton extends StatefulWidget {
  final VoidCallback? onTap; // Добавляем callback для обработки нажатия

  AvatarButton({this.onTap});

  @override
  _AvatarButtonState createState() => _AvatarButtonState();
}

class _AvatarButtonState extends State<AvatarButton> with SingleTickerProviderStateMixin {
  bool isInTournament = false; // Начальное состояние

  void toggleState() {
    setState(() {
      isInTournament = !isInTournament;
    });
    _gotoDetailsPage(context);
  }

  void _gotoDetailsPage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Фиксированные координаты центра кнопки
    final Offset buttonCenter = Offset(screenWidth - 18 - 25, MediaQuery.of(context).padding.top + 45 + 23);

    // Вычисляем максимальный радиус для полного покрытия экрана
    final double radius = math.sqrt(math.pow(screenWidth, 2) + math.pow(screenHeight, 2));

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            var circleRadius = Tween(begin: 0.0, end: radius).evaluate(animation);
            return ClipPath(
              clipper: CircleRevealClipper(buttonCenter, circleRadius),
              child: child,
            );
          },
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          toggleState();
        }
      },
      child: Container(
        padding: EdgeInsets.all(3),  // Отступ для создания кольца
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isInTournament ? Colors.blue : AppTheme.colors.background01,  // Цвет кольца
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://avatars.cloudflare.steamstatic.com/b2d93ef9b6fe943afa8744a635f99285ad3c73e8_full.jpg'),
          backgroundColor: isInTournament ? Colors.green : Colors.red,
          radius: 25,  // Размер внутреннего аватара
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(child: Stack(children: [
      Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(title: Text('Details'), backgroundColor: Colors.red,),
        body: Center(
          child: Text('Details Screen', style: Theme
              .of(context)
              .textTheme
              .headline4),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          margin: EdgeInsets.only(top: 5, right: 10),
          width: 50,
          height: 50,
          child: AvatarButton(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      )
    ]
    )
    )
    );
  }
}

class CircleRevealClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleRevealClipper(this.center, this.radius);

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) => radius != oldClipper.radius || center != oldClipper.center;
}

