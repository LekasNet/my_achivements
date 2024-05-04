import 'package:flutter/material.dart';

import '../domain/requests/loginRequest.dart';
import '../domain/requests/registrationRequest.dart';
import 'inputDecoration.dart';

class RegistrationProcess extends StatefulWidget {
  @override
  _RegistrationProcessState createState() => _RegistrationProcessState();
}

class _RegistrationProcessState extends State<RegistrationProcess> with TickerProviderStateMixin {
  int _currentStep = 0;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _informationFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hasNoMiddleName = false;
  DateTime selectedDate = DateTime.now();
  String role = "Школьник";
  late Widget currentForm;
  late String _loginError = "";

  Widget _buildLoginForm() {
    void rerun() {
      _loginFormKey.currentState!.validate();
    }
    return Column(
        key: _loginFormKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildInputField(_usernameController, 'Логин', (value) { if (_loginError.isEmpty) return _loginError; return null; }),
          SizedBox(height: 10),
          buildInputField(_passwordController, 'Пароль', null),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              bool isLoggedIn = await login(_usernameController.text, _passwordController.text, rerun);
              if (!isLoggedIn) {
                setState(() {
                  _loginError = 'Неправильный логин или пароль';
                });
                print("Login with: ${_usernameController.text}, ${_passwordController.text}");
              } else {
                // Переход к следующему экрану или обновление UI
                setState(() {
                  _loginError = '';
                });

              }
            },
            child: Text('Войти'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFF262A34),
              shape: StadiumBorder(),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _currentStep = 1;
              });
            },
            child: Text('Зарегистрироваться'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
          ),
        ],
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _registrationFormKey,
      child: Column(
          children: <Widget>[
            buildInputField(
                emailController,
                "Email",
                    (value) {
                  if (value!.isEmpty || !value.contains('@'))
                    return 'Введите корректный Email';
                  return null;
                }
            ),
            SizedBox(height: 10),
            buildInputField(
              usernameController,
              'Логин',
                  (value) {
                if (value!.isEmpty) return 'Введите имя пользователя';
                return null;
              },
            ),
            SizedBox(height: 10),
            buildInputField(
                passwordController,
                'Пароль',
                    (value) {
                  if (value!.isEmpty || value.length < 6)
                    return 'Пароль должен быть длиннее 6 символов';
                  return null;
                },
                obscure: true
            ),
            SizedBox(height: 10),
            buildInputField(
                confirmPasswordController,
                'Подтверждение пароля',
                    (value) {
                  if (value != passwordController.text)
                    return 'Пароли не совпадают';
                  return null;
                },
                obscure: true
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = 0;
                    });
                  },
                  child: Text('Войти'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFF262A34),
                    shape: StadiumBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_registrationFormKey.currentState!.validate()) {
                      setState(() {
                        _currentStep = 2;
                      });
                    }
                  },
                  child: Text('Вперёд'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFF262E57),
                    shape: const StadiumBorder(),
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }

  Widget _buildInformationForm() {
    return Form(
      key: _informationFormKey,
      child: Column(
        children: <Widget>[
          buildInputField(
            lastNameController,
            'Фамилия',
            (value) {
              if (value!.isEmpty) return 'Введите фамилию';
              return null;
            },
          ),
          SizedBox(height: 10),
          buildInputField(
            firstNameController,
            'Имя',
            (value) {
              if (value!.isEmpty) return 'Введите имя';
              return null;
            },
          ),
          SizedBox(height: 10),
          buildInputField(
            middleNameController,
            'Отчество',
            (value) {
              if (value!.isEmpty && !hasNoMiddleName) return 'Введите отчество или отметьте чекбокс';
              return null;
            },
          ),
          SizedBox(height: 10),
          CheckboxListTile(
            title: Text("У меня нет отчества"),
            value: hasNoMiddleName,
            onChanged: (bool? value) {
              setState(() {
                hasNoMiddleName = value!;
                if (hasNoMiddleName) middleNameController.text = "";
              });
            },
          ),
          SizedBox(height: 10),
          buildDateInputField(context, selectedDate, (newDate) {
            setState(() {
              selectedDate = newDate;
            });
          }),
          SizedBox(height: 10),
          buildDropdownButton(role, (newRole) {
            setState(() {
              role = newRole;
            });
          }),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentStep = 1;
                  });
                },
                child: Text('Назад'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_informationFormKey.currentState?.validate() ?? false) {
                    print("Регистрация: Email: ${emailController.text}, Username: ${usernameController.text}, Password: ${passwordController.text}");
                    print("Информация: Фамилия: ${lastNameController.text}, Имя: ${firstNameController.text}, Отчество: ${middleNameController.text}, Роль: $role");
                    saveUserData(
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        lastName: lastNameController.text,
                        firstName: firstNameController.text,
                        middleName: hasNoMiddleName ? null : middleNameController.text,
                        dateOfBirth: selectedDate,
                        role: role
                    );
                  }
                },
                child: Text('Зарегистрироваться'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF262E57),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case 0:
        currentForm = _buildLoginForm();
        break;
      case 1:
        currentForm = _buildRegistrationForm();
        break;
      default:
        currentForm = _buildInformationForm();
        break;
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: currentForm,
      ),
    );
  }
}
