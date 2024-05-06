import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../commons/GradientCard.dart';
import '../domain/requests/addArtivle.dart';
import 'inputDecoration.dart';

class AddArticleForm extends StatefulWidget {
  @override
  _AddArticleFormState createState() => _AddArticleFormState();
}

class _AddArticleFormState extends State<AddArticleForm> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String tags = '';
  String imageUrl = '';
  String category = 'News'; // Начальное значение
  List<String> categories = ['News', 'Tournaments'];
  DateTime? endDate; // Дата истечения для категории Tournament
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      submitArticle(
        title: titleController.text,
        description: descriptionController.text,
        tags: tagsController.text,
        imageUrl: imageUrlController.text,
        category: category,
        enddate: category == 'Tournaments' ? endDate : null,
      ).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Статья добавлена успешно')));
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: $error')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: category == 'Tournaments' ? 526 : 460,
        padding: const EdgeInsets.all(10.0), // Отступ от краёв экрана
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            // Уменьшенное скругление рамки
            child: GradientCenterContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildInputField(
                      titleController,
                      'Название',
                          (value) =>
                      value == null || value.isEmpty
                          ? 'Пожалуйста, введите название статьи'
                          : null
                  ),
                  SizedBox(height: 10,),
                  buildInputField(
                      descriptionController,
                      'Описание',
                          (value) =>
                      value == null || value.isEmpty
                          ? 'Пожалуйста, введите описание статьи'
                          : null
                  ),
                  SizedBox(height: 10,),
                  buildInputField(
                      tagsController,
                      'Теги (разделены запятыми)',
                      null
                  ),
                  SizedBox(height: 10,),
                  buildInputField(
                      imageUrlController,
                      'Ссылка на изображение',
                      null
                  ),
                  SizedBox(height: 10,),
                  buildDropdownButton(category, (newCategory) {
                    setState(() {
                      category = newCategory;
                      if (category == 'Tournaments') {
                        endDate = DateTime
                            .now(); // Инициализация даты, если ранее не было выбрано
                      }
                    });
                  },
                      items: categories
                  ),
                  if (category == 'Tournaments') buildDateInputField(
                      context, endDate!, (newDate) {
                    setState(() {
                      endDate = newDate;
                    });
                  }),
                  if (category == 'Tournaments') SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Добавить статью'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
