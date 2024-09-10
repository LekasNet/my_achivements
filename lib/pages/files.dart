import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../templates/imageDialog.dart';


class FileExplorer extends StatefulWidget {
  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  FirebaseStorage storage = FirebaseStorage.instance;

  // Функция для получения списка файлов и папок
  Future<List<Map<String, dynamic>>> _listFilesAndFolders(String path) async {
    ListResult result = await storage.ref(path).listAll();

    // Преобразуем папки (prefixes) в карты с добавлением '/'
    List<Map<String, dynamic>> folders = result.prefixes.map((prefix) {
      return {'name': prefix.name + '/', 'reference': prefix};
    }).toList();

    // Преобразуем файлы (items) в карты без добавления '/'
    List<Map<String, dynamic>> files = result.items.map((file) {
      return {'name': file.name, 'reference': file};
    }).toList();

    // Объединяем папки и файлы в один список
    return [...folders, ...files];
  }

  // Виджет для отображения файлов и папок
  Widget _buildFileFolderList(List<Map<String, dynamic>> references, String path) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // чтобы избежать скроллинга во вложенных списках
      itemCount: references.length,
      itemBuilder: (context, index) {
        var entry = references[index];
        String name = entry['name'];
        Reference reference = entry['reference'];
        final GlobalKey<_FolderIconState> folderIconKey = GlobalKey<_FolderIconState>();

        return Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          // Отступ между папками
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF252a32), // Основной фон папки
              borderRadius: BorderRadius.circular(15), // Округлые границы
              border: Border.all(
                color: Color(0xFF252a32), // Цвет границы такой же, как фон
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent, // Отключить подсветку нажатия
                highlightColor: Colors
                    .transparent, // Отключить подсветку при выделении
                  dividerColor: Colors.transparent
              ),
              child: ExpansionTile(
                visualDensity: VisualDensity.compact,
                tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white, // Цвет текста
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF333940),
                    // Более светлый фон для иконки папки
                    borderRadius: BorderRadius.circular(
                        12), // Скругление иконки папки
                  ),
                  child: FolderIcon(key: folderIconKey),
                ),
                backgroundColor: Colors.transparent,
                // Прозрачный фон внутри развернутого контейнера
                collapsedBackgroundColor: Colors.transparent,
                // Цвет закрытого контейнера
                childrenPadding: EdgeInsets.all(10),
                // Отступы внутри развернутого списка
                onExpansionChanged: (bool expanded) {
                  folderIconKey.currentState?.changeState(); // Вызываем смену состояния иконки

                },
                children: <Widget>[
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _listFilesAndFolders(reference.fullPath),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Ошибка: ${snapshot.error}',
                            style: TextStyle(color: Colors.white));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('Пустая папка',
                            style: TextStyle(color: Colors.white));
                      } else {
                        return Column(
                          children: snapshot.data!.map((fileEntry) {
                            return ListTile(
                              title: Text(
                                fileEntry['name'],
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                onFileTap(context, fileEntry['reference']);
                              },
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все файлы'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _listFilesAndFolders('/'), // Начальная папка
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет файлов или папок'));
          } else {
            return _buildFileFolderList(snapshot.data!, '/');
          }
        },
      ),
    );
  }
}


class FolderIcon extends StatefulWidget {
  const FolderIcon({super.key});

  @override
  _FolderIconState createState() => _FolderIconState();
}

class _FolderIconState extends State<FolderIcon> {
  bool _isOpen = false; // Переменная состояния для отслеживания открытия

  void changeState() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _isOpen ? Icons.folder_open : Icons.folder, // Иконка папки
      color: Colors.amber, // Цвет иконки
      size: 40,
    );
  }
}



// onFileTap(context, reference);