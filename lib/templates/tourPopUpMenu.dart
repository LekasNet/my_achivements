import 'package:flutter/material.dart';
import 'package:my_achievements/commons/globals.dart';

import '../commons/theme.dart';
void tourPopupMenu(BuildContext context, String imagePath, String title, String description, String tag) {
  AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: Navigator.of(context),
  );

  // Начинаем анимацию от 75% размера и с полной прозрачности
  controller.forward(from: 0.0);

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.75, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
              child: Dialog(
                backgroundColor: AppTheme.darkThemeColors.background01,
                insetPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: cardBorders * 2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: cardBorders,
                            child: Image.network(
                              imagePath,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Text(
                                description,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: tag == "news"
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Открыть новость",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                          : Container(
                        width: 260,
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        clipBehavior: Clip.none,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                  // border: Border.all(color: Colors.grey.shade200, width: 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: MaterialButton(
                                  onPressed: () {
                                    // Логика для "Регистрация"
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                  child: const Text(
                                    "Регистрация",
                                    style: TextStyle(

                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                      color: Colors.green, width: 1),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: MaterialButton(
                                  onPressed: () {
                                    // Логика для "К соревнованию"
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                  color: Colors.green,
                                  child: const Text(
                                    "К соревнованию",
                                    style: TextStyle(

                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    // Очистка ресурсов контроллера анимации при закрытии диалога
    controller.reverse().then((value) => controller.dispose());
  });
}

