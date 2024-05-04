import 'package:flutter/material.dart';

class GradientCenterContainer extends StatelessWidget {
  final Widget child; // Принимаемый виджет

  GradientCenterContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            // Задаем радиус закругления
            child: IntrinsicHeight(
              child: Container(
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
                    stops: [0.0, 0.07, 0.93, 1.0],
                  ),
                ),
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xa0383E4D),
                          Color(0x10383E4D),
                          Color(0x10383E4D),
                          Color(0xa0383E4D),
                        ],
                        stops: [0.0, 0.07, 0.93, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Align(
                        alignment: Alignment.center,
                        child: child, // Используем переданный виджет
                      ),
                    )
                ),
              ),
            ),
          ),
        )
    );
  }
}
