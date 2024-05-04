import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../commons/globals.dart';

Widget buildInputField(TextEditingController controller, String hint, String? Function(String?)? validate, {bool obscure=false}) {
  return TextFormField(
    controller: controller,
    cursorColor: Colors.white,
    validator: validate,
    obscureText: obscure,
    decoration: InputDecoration(
      labelText: hint,
      labelStyle: const TextStyle(
        color: Color(0x80FFFFFF),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none, // Убрали видимую границу
      ),
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
    ),
    style: TextStyle(color: Colors.white),
  );
}

Future<void> selectDate(BuildContext context, DateTime selectedDate, Function(DateTime) onDateSelected) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    locale: const Locale('ru', 'RU'),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Colors.grey,
            onPrimary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: Colors.blue[900],
        ),
        child: child!,
      );
    },
  );
  if (picked != null && picked != selectedDate) {
    onDateSelected(picked);
  }
}

Widget buildDateInputField(BuildContext context,  DateTime selectedDate, Function(DateTime) onDateSelected) {
  return GestureDetector(
    onTap: () => selectDate(context, selectedDate, onDateSelected),
    child: AbsorbPointer(
      child: TextFormField(
        controller: TextEditingController(text: DateFormat('dd-MM-yyyy').format(selectedDate)),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: 'Дата рождения',
          labelStyle: TextStyle(
            color: Color(0x80FFFFFF),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
        ),
        style: TextStyle(color: Color(0x80FFFFFF)),
      ),
    ),
  );
}

Widget buildDropdownButton(String role, Function(String) onRoleChanged) {
  return Container(

    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30), // Скругление углов
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: role,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Иконка стрелки
        iconSize: 24,
        dropdownColor: Colors.blueGrey[900], // Цвет фона выпадающего списка
        style: TextStyle(
          color: Colors.white, // Цвет текста элементов
          fontSize: 16,
        ),
        onChanged: (String? newValue) {
          onRoleChanged(newValue!);
        },
        items: roles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
  );
}


