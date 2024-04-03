import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    return IconButton(
      onPressed: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          toggleState();
        }
      },
      icon: CircleAvatar(

        backgroundImage: NetworkImage('https://avatars.cloudflare.steamstatic.com/b2d93ef9b6fe943afa8744a635f99285ad3c73e8_full.jpg'),

        backgroundColor: isInTournament ? Colors.green : Colors.red,

        radius: 25,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Stack(children: [
      Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text('Details'), backgroundColor: Colors.red,),
      body: Center(
        child: Text('Details Screen', style: Theme.of(context).textTheme.headline4),
      ),
      ),
      Positioned(
        top: 5, // Регулируйте эти значения в соответствии с вашим интерфейсом
        right: 10,
        child: AvatarButton(
          onTap: () {
            Navigator.pop(context);
          },
        ), // Ваша кнопка с аватаром
      ),
        ]
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

