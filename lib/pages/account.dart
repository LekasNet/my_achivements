import 'package:flutter/material.dart';
import 'package:my_achievements/domain/requests/adminCheck.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/routes/navigator.dart';
import '../templates/articleAdding.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String role = '';
  bool isAdmin = false;
  DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      firstName = prefs.getString('firstName') ?? '';
      middleName = prefs.getString('middleName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      role = prefs.getString('role') ?? '';
      dateOfBirth = DateTime.tryParse(prefs.getString('dateOfBirth') ?? '');
      isAdmin = prefs.getBool('isAdmin') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Профиль"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.red,),
            onPressed: () => logout(context),
            tooltip: "Выйти из аккаунта",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Пример URL аватарки
                  backgroundColor: Colors.grey[200],
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lastName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(firstName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    middleName.isNotEmpty ? Text(middleName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)) : Text(username, style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Text(username, style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Отступ слева и справа
              child: Divider(
                thickness: 1, // Толщина линии
                color: Color(0x77838383), // Цвет линии
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'Email: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextSpan(text: email, style: TextStyle(fontSize: 20)),
                  ]
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Отступ слева и справа
              child: Divider(
                thickness: 1, // Толщина линии
                color: Color(0x77838383), // Цвет линии
              ),
            ),
            Text('Роль: $role'),
            if (dateOfBirth != null)
              Text('Дата рождения: ${dateOfBirth!.day}.${dateOfBirth!.month}.${dateOfBirth!.year}'),
            if (isAdmin) AddArticleForm(),
          ],
        ),
      ),
    );
  }
  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();  // Очищаем все сохраненные данные
    Provider.of<TabManager>(context, listen: false).setCurrentIndex(3);  // Перенаправляем на страницу входа
  }
}
