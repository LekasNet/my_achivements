import 'package:flutter/material.dart';
import 'package:my_achivements/commons/globals.dart';

import 'decorations.dart';

class CustomAppBar extends StatefulWidget {
  final Widget child;

  const CustomAppBar({super.key, required this.child});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 0 && !_isScrolled) {
          setState(() => _isScrolled = true);
        } else if (_scrollController.offset <= 0 && _isScrolled) {
          setState(() => _isScrolled = false);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 25.0,
          floating: false,
          pinned: true,
          elevation: _isScrolled ? 4.0 : 0.0,
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(pageName),
          ),
        ),
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top),
            child: widget.child,
          )
        )
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


class CustomTopBar extends StatefulWidget {
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<CustomTopBar> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double fem = MediaQuery
        .of(context)
        .size
        .width / baseWidth;
    double ffem = fem * 0.97;
    double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return Container(
      width: baseWidth,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(1),
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0),
            ],
            stops: [0.36, 0.84, 0.96, 1]
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, statusBarHeight + 7 * fem, 0, 0),
            color: Colors.transparent,
            // Замените на цвет вашего фона
            height: 60.0,
            // Замените на необходимую высоту
            alignment: Alignment.topCenter,
            child: const Text(
              'Достижения',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          Positioned(
            top: 0, // Регулируйте эти значения в соответствии с вашим интерфейсом
            right: 10,
            child: AvatarButton(), // Ваша кнопка с аватаром
          ),
        ],
      )
    );
  }
}