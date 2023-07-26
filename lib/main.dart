import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -убрал appbar
      // -Убрал надпись PsyScan, вместо этого картинка будет
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //картинка на задний фон
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 700,
              width: 450,
              color: Colors.white,
              child: Image(
                image: AssetImage('assets/PsyScan.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //

          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // -форма кнопки
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 23), // -Поменял размер
                  textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', fontWeight: FontWeight.bold), // -Поменял размер
                  primary: Color.fromARGB(255, 255, 255, 255), // -Изменил цвет
                  onPrimary: const Color.fromARGB(255, 0, 0, 0), // -Добавил строку
                  side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)), // -Добавил рамку
                ),
                child: Text('Вход'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 23), // -Поменял размер
                    textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', fontWeight: FontWeight.bold), // -Поменял размер
                    primary: Color.fromARGB(255, 24, 24, 24), // -Изменил цвет
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // -форма кнопки

                    onPrimary: Colors.white
                ),
                child: Text('Регистрация'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _loginFieldEmpty = false;
  bool _passwordFieldEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -убрал appbar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Вход', style: TextStyle(fontSize: 40, fontFamily: 'Manrope', fontWeight: FontWeight.bold)), //  -Изменил размер
            SizedBox(height: 40), // -Изменил расстояние
            TextFormField(
              decoration: InputDecoration(
                labelText: '    Логин', // -пробелы добавил
                errorText: _loginFieldEmpty ? '   Пожалуйста, введите логин' : null,// -пробелы добавил
              ),
              controller: _loginController,
            ),
            SizedBox(height: 20), // -+строка
            TextFormField(
              decoration: InputDecoration(
                labelText: '    Пароль', // -пробелы добавил
                errorText: _passwordFieldEmpty ? '   Пожалуйста, введите пароль' : null,// -пробелы добавил
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _loginController.text.isEmpty
                      ? _loginFieldEmpty = true
                      : _loginFieldEmpty = false;

                  _passwordController.text.isEmpty
                      ? _passwordFieldEmpty = true
                      : _passwordFieldEmpty = false;

                  if (!_loginFieldEmpty && !_passwordFieldEmpty) {
                    // Здесь можно добавить логику для входа
                  }
                });
              },

              // -добавил кусок ниже
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 170, vertical: 24),
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Manrope', ),
                  primary: Color.fromARGB(255, 24, 24, 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  onPrimary: Colors.white
              ), // -до сюда

              child: Text('Войти'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('У вас нет аккаунта? Зарегистрируйтесь',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.black, // -Цвет с голубого на чёрный
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  bool _loginFieldEmpty = false;
  bool _passwordFieldEmpty = false;
  bool _repeatPasswordFieldEmpty = false;
  bool _passwordsDoNotMatch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -убрал appbar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Регистрация', style: TextStyle(fontSize: 40, fontFamily: 'Manrope', fontWeight: FontWeight.bold)),
            SizedBox(height: 40), // -Изменил расстояние
            TextFormField(
              decoration: InputDecoration(
                labelText: '   Логин', // -пробелы добавил
                errorText: _loginFieldEmpty ? 'Пожалуйста, введите логин' : null,
              ),
              controller: _loginController,
            ),
            SizedBox(height: 20), // -+строка
            TextFormField(
              decoration: InputDecoration(
                labelText: '   Пароль', // -пробелы добавил
                errorText: _passwordFieldEmpty ? 'Пожалуйста, введите пароль' : null,
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20), // -+строка
            TextFormField(
              decoration: InputDecoration(
                labelText: '   Повторите пароль', // -пробелы добавил
                errorText: _repeatPasswordFieldEmpty ? 'Пожалуйста, повторите пароль' : null,
              ),
              controller: _repeatPasswordController,
              obscureText: true,
            ),
            if (_passwordsDoNotMatch)
              Text(
                'Пароли не совпадают',
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 40), // -Изменил расстояние
            ElevatedButton(

              // -добавил кусок ниже
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 120, vertical: 24),
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Manrope', ),
                  primary: Color.fromARGB(255, 24, 24, 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  onPrimary: Colors.white
              ), // -до сюда

              onPressed: () {
                setState(() {
                  _loginController.text.isEmpty
                      ? _loginFieldEmpty = true
                      : _loginFieldEmpty = false;

                  _passwordController.text.isEmpty
                      ? _passwordFieldEmpty = true
                      : _passwordFieldEmpty = false;

                  _repeatPasswordController.text.isEmpty
                      ? _repeatPasswordFieldEmpty = true
                      : _repeatPasswordFieldEmpty = false;

                  if (_passwordController.text != _repeatPasswordController.text) {
                    _passwordsDoNotMatch = true;
                  } else {
                    _passwordsDoNotMatch = false;
                  }

                  if (!_loginFieldEmpty && !_passwordFieldEmpty && !_repeatPasswordFieldEmpty && !_passwordsDoNotMatch) {
                    // Здесь можно добавить логику для регистрации
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AboutMePage()),
                    );
                  }
                });
              },
              child: Text('Зарегистрироваться'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'У вас уже есть аккаунт? Войдите',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.black, // -Цвет с голубого на чёрный
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String _name = '';
  String _surname = '';
  int _age = 0;
  Gender _selectedGender = Gender.none;

  final _formKey = GlobalKey<FormState>(); // Добавляем ключ для валидации формы

  void _onNameChanged(String value) {
    setState(() {
      _name = value;
    });
  }

  void _onSurnameChanged(String value) {
    setState(() {
      _surname = value;
    });
  }

  void _onAgeChanged(String value) {
    setState(() {
      _age = int.tryParse(value) ?? 0;
    });
  }

  void _onGenderChanged(Gender value) {
    setState(() {
      _selectedGender = value;
    });
  }

  void _submitForm() {
    // Проверяем, все ли поля заполнены
    if (_formKey.currentState?.validate() == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalCabinetPage(
            name: _name,
            surname: _surname,
            age: _age,
            gender: _selectedGender,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -убрал appbar
      body: Center(
        child: Form(
          key: _formKey, // Привязываем ключ формы к форме
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Привет!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
              SizedBox(height: 20), // -+строка
              Text('Как вас зовут?'), // - тебя -> 'вас', проявляем уважение к пользователю
              TextFormField(
                decoration: InputDecoration(labelText: '   Имя'), // -добавил пробелы
                onChanged: _onNameChanged,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Введите имя';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я ]')),
                ],
              ),
              SizedBox(height: 20), // -+строка
              TextFormField(
                decoration: InputDecoration(labelText: '   Фамилия'), // -добавил пробелы
                onChanged: _onSurnameChanged,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Введите фамилию';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я ]')),
                ],
              ),
              SizedBox(height: 10), // -+строка
              Text('Сколько вам лет?'), // -тебе -> вам лет
              TextFormField(
                decoration: InputDecoration(labelText: '   Возраст'), // -добавил пробелы
                onChanged: _onAgeChanged,
                validator: (value) {
                  if (value?.isEmpty == true || int.tryParse(value!) == null) {
                    return 'Введите корректный возраст';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]?$|^100$')),
                ],
              ),
              SizedBox(height: 10), // -+строка
              Text('Ваш пол'), // -твой -> ваш пол
              Column(
                children: [
                  RadioListTile<Gender>(
                    title: Text('Муж.'),
                    value: Gender.male,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      if (value != null) {
                        _onGenderChanged(value);
                      }
                    },
                  ),
                  RadioListTile<Gender>(
                    title: Text('Жен.'),
                    value: Gender.female,
                    groupValue: _selectedGender,
                    onChanged: (Gender? value) {
                      if (value != null) {
                        _onGenderChanged(value);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(

                // -добавил кусок ниже
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Manrope', ),
                    primary: Color.fromARGB(255, 24, 24, 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    onPrimary: Colors.white
                ), // -до сюда

                onPressed: _submitForm, // Вызываем метод для обработки нажатия кнопки "Далее"
                child: Text('Далее'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Gender {
  none,
  male,
  female,
}

class PersonalCabinetPage extends StatelessWidget {
  final String name;
  final String surname;
  final int age;
  final Gender gender;

  PersonalCabinetPage({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    String genderText = gender == Gender.male ? 'Мужской' : gender == Gender.female ? 'Женский' : '';

    return Scaffold(
        extendBodyBehindAppBar: true, // -сделал appbar прозрачным
        appBar: AppBar(
          // -убрал текст на appbar
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutMePage(),
                  ),
                );
              },
              icon: Icon(Icons.edit, color: Colors.black), // -перекрасил эдит
            ),
          ],
          backgroundColor: Colors.transparent, // -добавил строку
          elevation: 0, // -и эту
        ),
        body: Center(
          child:
          Column(
              children: <Widget> [ // Аватар
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 150, 0, 40),
                    child: Column(
                        children: <Widget> [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.grey,
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                          ),
                          Text(                          //Имя
                            '$name $surname',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Manrope",
                            ),
                          ),
                          Row(                           //Возраст и пол
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '$age',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Manrope"
                                ),
                              ),
                              Text(
                                '$genderText',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          ),
                        ])
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget> [

                          ElevatedButton(      // Кнопка теста
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestStartPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(

                              padding: EdgeInsets.all(16.0),
                              fixedSize: Size(324, 56),
                              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white70),
                              primary: Color.fromRGBO(10, 123, 143, 1.0),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                            child: Text('Тест'),
                          ),])
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(            // Кнопка углубленной диагностики
                        onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdvancedDiagnosisPage()),
                    );
                        },
                        child: Text('Углубленная диагностика'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          fixedSize: Size(324, 56),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white70),
                          primary: Color.fromRGBO(10, 123, 143, 1.0),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      )
                    ],
                  ),)
              ]
          ),
        )
    );
  }
}

class Question {
  final String questionText;

  Question(this.questionText);
}

class TestStartPage extends StatelessWidget {
  void _resetTotalScore() {
    _totalScore = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Color.fromRGBO(12, 150, 175, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
              child: Text(
                'Оцените тяжесть депрессии',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  wordSpacing: -1,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 60),
              child: Text(
                'Представленный тест разработан на базе "Госпитальной Шкалы Тревоги и Депрессии для выявления и оценки тяжести тревожного расстройства, депрессии. Данный тест обычно используется как скрининг-тест, тогда как для более детального изучения выявленных нарушений рекомендуется обследование у психотерапевта или психиатра.',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 20,
                  letterSpacing: 1,
                  wordSpacing: -1,
                  color: Colors.white,
                ),
                softWrap: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _resetTotalScore(); // Обнуляем _totalScore перед началом теста
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage1(totalScore: _totalScore),
                  ),
                );
              },
              child: Text('Начать тест'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                fixedSize: Size(324, 56),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                primary: Colors.white,
                onPrimary: Colors.black87,
                side: BorderSide(color: Colors.black87, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _totalScore = 0;

class QuestionPage1 extends StatefulWidget {
  final int totalScore;

  QuestionPage1({required this.totalScore});

  @override
  _QuestionPage1State createState() => _QuestionPage1State();
}

class _QuestionPage1State extends State<QuestionPage1> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 1',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'То, что приносило мне большое удовольствие и сейчас вызывает у меня такое же чувство.',
                    nextQuestionIndex: 2,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage2(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Определенно это так'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Наверное, это так'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Лишь в очень малой степени это так'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Это совсем не так'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage2 extends StatefulWidget {
  final int totalScore;

  QuestionPage2({required this.totalScore});

  @override
  _QuestionPage2State createState() => _QuestionPage2State();
}

class _QuestionPage2State extends State<QuestionPage2> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 2',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Я способен рассмеяться и увидеть в том или ином событии смешное.',
                    nextQuestionIndex: 3,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage3(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Определенно это так'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Наверное, это так'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Лишь в очень малой степени это так'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Это совсем не так'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage3 extends StatefulWidget {
  final int totalScore;

  QuestionPage3({required this.totalScore});

  @override
  _QuestionPage3State createState() => _QuestionPage3State();
}

class _QuestionPage3State extends State<QuestionPage3> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 3',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Я испытываю бодрость.                                                           ',
                    nextQuestionIndex: 4,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage4(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Всё время'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Иногда'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Очень редко'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Совсем не испытываю'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage4 extends StatefulWidget {
  final int totalScore;

  QuestionPage4({required this.totalScore});

  @override
  _QuestionPage4State createState() => _QuestionPage4State();
}

class _QuestionPage4State extends State<QuestionPage4> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 4',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Мне кажется, что я все стал делать очень медленно.',
                    nextQuestionIndex: 5,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage5(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Это совсем не так'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Иногда'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Часто'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Практически все время'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage5 extends StatefulWidget {
  final int totalScore;

  QuestionPage5({required this.totalScore});

  @override
  _QuestionPage5State createState() => _QuestionPage5State();
}

class _QuestionPage5State extends State<QuestionPage5> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 5',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Я не слежу за своей внешностью.                                                    ',
                    nextQuestionIndex: 6,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage6(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Я слежу за собой так же, как и раньше'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Может быть, я стал меньше уделять этому внимания'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Я не уделяю этому столько, сколько нужно'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Это так'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage6 extends StatefulWidget {
  final int totalScore;

  QuestionPage6({required this.totalScore});

  @override
  _QuestionPage6State createState() => _QuestionPage6State();
}

class _QuestionPage6State extends State<QuestionPage6> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 6',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Я считаю, что мои дела (занятия, увлечения) могут принести мне чувство удовлетворения.',
                    nextQuestionIndex: 7,       // поменять индекс
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionPage7(totalScore: _totalScore),  //поменять старницу
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Точно так же, как и обычно'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Да, но не в той степени, как раньше'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Значительно меньше, чем обычно'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Совсем так не считаю'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Далее'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

class QuestionPage7 extends StatefulWidget {
  final int totalScore;

  QuestionPage7({required this.totalScore});

  @override
  _QuestionPage7State createState() => _QuestionPage7State();
}

class _QuestionPage7State extends State<QuestionPage7> with AutomaticKeepAliveClientMixin {
  int? _selectedAnswerIndex;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBodyBehindAppBar: true,               // отсюда
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:
        Container(
            color: Color.fromRGBO(12, 150, 175, 1),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
                    child:
                    Text(
                        'Вопрос 7',
                        style: TextStyle (
                          fontFamily: 'Manrope',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: -1,
                          color: Colors.white,
                        )
                    ),
                  ),
                  _buildQuestionPage(
                    questionText: 'Я могу получить удовольствие от хорошей книги, радио- или телепрограммы.',
                    nextQuestionIndex: 8,
                    onNextQuestion: () {
                      if (_selectedAnswerIndex != null) {
                        _calculateScore();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(totalScore: _totalScore),
                          ),
                        );
                      }
                    },
                  ),
                ]
            )
        ));
  }

  Widget _buildQuestionPage({
    required String questionText,
    required int nextQuestionIndex,
    required VoidCallback onNextQuestion,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(                                //отсюда
            padding: EdgeInsets.all(15),
            child:
            Text(
              questionText,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 25,
                letterSpacing: 1,
                wordSpacing: -1,
                color: Colors.white,
              ),
              softWrap: true,
            ),
          ),                                      // до сюда
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAnswerButton(0, 'Часто'),
              SizedBox(height: 10),
              _buildAnswerButton(1, 'Иногда'),
              SizedBox(height: 10),
              _buildAnswerButton(2, 'Редко'),
              SizedBox(height: 10),
              _buildAnswerButton(3, 'Очень редко'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,         //отсюда
              onPrimary: Colors.white,
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
              fixedSize: Size(150, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),                                      // до сюда
            onPressed: _selectedAnswerIndex != null ? onNextQuestion : null,
            child: Text('Закончить тест'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButton(int index, String text) {
    final bool isSelected = _selectedAnswerIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedAnswerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(375, 50),                                                        //отсюда
        textStyle: TextStyle(fontSize: 15, fontFamily: 'Manrope', color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        primary: Colors.white,
        onPrimary: Colors.black87,
        side: BorderSide(color: isSelected ? Colors.green : Colors.black87, width: 2),
        //primary: null,

      ),
      child: Text(text),
    );
  }

  void _calculateScore() {
    if (_selectedAnswerIndex != null) {
      switch (_selectedAnswerIndex) {
        case 0:
          _totalScore += 0;
          break;
        case 1:
          _totalScore += 1;
          break;
        case 2:
          _totalScore += 2;
          break;
        case 3:
          _totalScore += 3;
          break;
      }
    }
  }
}

Widget _getNextQuestionPage(int questionIndex) {
  switch (questionIndex) {
    case 1:
      return QuestionPage1(totalScore: _totalScore);
    case 2:
      return QuestionPage2(totalScore: _totalScore);
    case 3:
      return QuestionPage3(totalScore: _totalScore);
    case 4:
      return QuestionPage4(totalScore: _totalScore);
    case 5:
      return QuestionPage5(totalScore: _totalScore);
    case 6:
      return QuestionPage6(totalScore: _totalScore);
    case 7:
      return QuestionPage7(totalScore: _totalScore);
    default:
      return Container();
  }
}

class ResultPage extends StatelessWidget {
  final int totalScore;

  ResultPage({required this.totalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 40),
                    child:
                    Text(
                      'Результаты теста',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          children: [
                            Text(
                              'Обратите внимание',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 20), // -до сюда
                            // -от сюда
                            Text(
                              'Результаты теста - примерные, ориентировочные. Опытный врач может как подтвердить их, так и опровергнуть.Если вас беспокоит ваше психическое состояние, не откладывайте визит к врачу-психотерапевту',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 17,
                                color: Colors.red,
                              ),
                              softWrap: true,
                            ),
                          ])),
                ),


                Text(
                  'Вы набрали $totalScore баллов',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (totalScore >= 0 && totalScore <= 7)

                  Text(
                    'Это норма! Вы не страдаете от депрессии.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      letterSpacing: 1,
                      wordSpacing: -1,
                    ),
                    softWrap: true,),
                if (totalScore >= 8 && totalScore <= 10)
                  Text('Так называемое пограничное состояние. Рекомендуется обратиться к психологу или психотерапевту,'+
                      'т.к. в случае игнорирования первых симптомов, ваше состояние может ухудшиться, что может привести к '+
                      'снижению уверенности в себе, апатии, внутреннему напряжению и снижению качества жизни.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      letterSpacing: 1,
                      wordSpacing: -1,
                    ),),
                if (totalScore >= 11 && totalScore <= 21)
                  Text('Серьезный повод обратиться к психотерапевту т.к. Ваша болезнь не пройдет сама собой, а будет'+
                      'лишь прогрессировать. Невылеченная депрессия может привести к мыслям о суициде. Психотерапевт может'+
                      'полностью снять или существенно облегчить состояние более чем у 80% пациентов. Лечение улучшит психическое'+
                      'состояние, физическое здоровье, течение других хронических заболеваний, устраняя болевые ощущения, общую'+
                      'слабость, бессонницу и другие симптомы.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      letterSpacing: 1,
                      wordSpacing: -1,
                    ),
                  ),

                SizedBox(height: 20),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget> [

                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestStartPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(

                              padding: EdgeInsets.all(16.0),
                              fixedSize: Size(324, 56),
                              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                              primary: Colors.black87,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                            child: Text('Пройти тест заново'),
                          ),])
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 70),
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdvancedDiagnosisPage()),
                          );
                        },
                        child: Text('Углубленная диагностика'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          fixedSize: Size(324, 56),
                          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          primary: Color.fromRGBO(10, 123, 143, 1.0),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      )
                    ],
                  ),)
              ]),
        ));
  }
}

class AdvancedDiagnosisPage extends StatefulWidget {
  @override
  _AdvancedDiagnosisPageState createState() => _AdvancedDiagnosisPageState();
}

class _AdvancedDiagnosisPageState extends State<AdvancedDiagnosisPage> {
  String _selectedOption = 'Аудио';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // -сделал appbar прозрачным
      appBar: AppBar(
        backgroundColor: Colors.transparent, // -добавил строку
        elevation: 0,), // -и эту

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Углубленная диагностика', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)), // -добавил стилёк
            SizedBox(height: 50), // -+строка
            Text('Если вы хотите уточнить диагноз, то можете приложить аудио, видео или текстовый материал дя анаиза.', style: TextStyle(fontSize: 15)), // -добавил стилёк
            SizedBox(height: 70), // -изменил размер
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOption = 'Аудио';
                    });
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    textStyle: TextStyle(fontSize: 15),
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ), // -до сюда

                  child: Text('Аудио'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOption = 'Видео';
                    });
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    textStyle: TextStyle(fontSize: 15),
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ), // -до сюда

                  child: Text('Видео'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOption = 'Текст';
                    });
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    textStyle: TextStyle(fontSize: 15),
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    side: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ), // -до сюда

                  child: Text('Текст'),
                ),
              ],
            ),
            SizedBox(height: 40),
            _selectedOption == 'Аудио'
                ? Column(
              children: [
                Text('Вы можете выбрать готовую запись или записать новую в приложении.', style: TextStyle(fontSize: 15)), // -добавил стилёк
                SizedBox(height: 20), // -+строка
                ElevatedButton(
                  onPressed: () {
                    _pickAudioFile();
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                      textStyle: TextStyle(fontSize: 15),
                      primary: Color.fromARGB(255, 24, 24, 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPrimary: Colors.white
                  ), // -до сюда

                  child: Text('Выбрать запись'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // При нажатии на кнопку "Записать новую" переходим на страницу записи аудио.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AudioRecordingPage()),
                    );
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                      textStyle: TextStyle(fontSize: 15),
                      primary: Color.fromARGB(255, 79, 135, 150),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPrimary: Colors.white
                  ), // -до сюда

                  child: Text('Записать новую'),
                ),
              ],
            )
                : _selectedOption == 'Видео'
                ? Column(
              children: [
                Text('Вы можете выбрать готовое видео или записать новое в приложении.', style: TextStyle(fontSize: 15)), // -добавил стилёк
                SizedBox(height: 20), // -+строка
                ElevatedButton(
                  onPressed: () {
                    getVideo(ImageSource.gallery);
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                      textStyle: TextStyle(fontSize: 15),
                      primary: Color.fromARGB(255, 24, 24, 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPrimary: Colors.white
                  ), // -до сюда

                  child: Text('Выбрать видео'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getVideo(ImageSource.camera);
                  },

                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                      textStyle: TextStyle(fontSize: 15),
                      primary: Color.fromARGB(255, 79, 135, 150),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPrimary: Colors.white
                  ), // -до сюда

                  child: Text('Записать новое'),
                ),
              ],
            )
                : Column(
              children: [
                Text('Вы можете ввести текст для анализа.', style: TextStyle(fontSize: 15)), // -добавил стилёк
                SizedBox(height: 20), // -+строка
                ElevatedButton(
                  onPressed: () {
                    // При нажатии на кнопку "Добавить текст" переходим на страницу ввода текста.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextEntryPage()),
                    );
                  },
                  // -добавил кусок ниже
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                      textStyle: TextStyle(fontSize: 15),
                      primary: Color.fromARGB(255, 24, 24, 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      onPrimary: Colors.white
                  ), // -до сюда

                  child: Text('Добавить текст', ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Функция выбора аудио из "проводника" (или типа того). В конце функции вывод в консоль пути выбранного аудио и др.
  void _pickAudioFile() async {

    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(type: FileType.custom,
        allowedExtensions: ['mp3','aac','ogg','wma','wav'], allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

  // Функция записи видео и выбора видео из галереи (проводника)
  final picker = ImagePicker();
  Future getVideo(
      ImageSource img,
      ) async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      final pickedFile = await picker.pickVideo(
          source: img,
          preferredCameraDevice: CameraDevice.front,
          maxDuration: const Duration(minutes: 5));
      print(pickedFile!.path);
    }
  }

  // Проверка и запрос разрешения на использование камеры
  Future<bool> checkPermission() async {
    if (!await Permission.camera.isGranted) {
      PermissionStatus status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}

// Страница записи аудио
class AudioRecordingPage extends StatefulWidget {
  @override
  _AudioRecordingPage createState() => _AudioRecordingPage();
}

AudioPlayer audioPlayer = AudioPlayer();

class _AudioRecordingPage extends State<AudioRecordingPage> {
  String statusText = "";
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // -сделал appbar прозрачным
      appBar: AppBar(
        backgroundColor: Colors.transparent, // -добавил строку
        elevation: 0,), // -и эту

      body: Column(children: [
        // -Иконочки
        // -Добавил иконку микрофона
        SizedBox(height: 300),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: () async { startRecord(); },
                    icon: Icon(Icons.mic_none, size: 45, color: Colors.red),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0.0)), label: Text('')
                ),
                SizedBox(width: 70),
                ElevatedButton.icon(onPressed: () { pauseRecord(); },
                    icon: Icon(Icons.pause, size: 45, color: Colors.blue),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0.0)), label: Text('')
                ),
                SizedBox(width: 70),
                ElevatedButton.icon(onPressed: () { stopRecord(); },
                    icon: Icon(Icons.stop, size: 45, color: Colors.green),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0.0)), label: Text('')
                ),
              ],
            ),
          ],
        ),
        // -до сюда
        SizedBox(height: 25), // -добавил строку
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            statusText,
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
        ElevatedButton(

          // -добавил кусок ниже
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 150, vertical: 24),
              textStyle: TextStyle(fontSize: 15),
              primary: Color.fromARGB(255, 80, 132, 175),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPrimary: Colors.white, //-строчкка нужная
            ), // -до сюда

            onPressed: () {
              if (isComplete && recordFilePath != null) {
                audioPlayer.stop();
                play();
              }
            }, child: Text("Воспроизвести")
        ),
        SizedBox(height: 25),
        ElevatedButton(

          // -добавил кусок ниже
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 167, vertical: 24),
              textStyle: TextStyle(fontSize: 15),
              primary: Color.fromARGB(255, 24, 24, 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPrimary: Colors.white, //-строчкка нужная
            ), // -до сюда

            onPressed: () {
              if (isComplete && recordFilePath != null) {
                Navigator.pop(context);
              }


            }, child: Text( "Отправить")
        ),
      ]),
    );
  }

  // Проверка и запрос разрешения на использование микрофона
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // Функция старта записи аудио
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Запись...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Ошибка записи--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  // Функция приостановки записи аудио
  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Запись...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Запись приостановлена";
        setState(() {});
      }
    }
  }

  // Функция завершения записи аудио
  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Запись завершена";
      isComplete = true;
      setState(() {});
    }
  }

  // Функция продолжения записи аудио после паузы
  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Запись...";
      setState(() {});
    }
  }

  String recordFilePath = '';

  // Функция воспроизведения записанного аудио
  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;

  // Получение пути расположения записанного аудио и вывод в консоль
  Future<String> getFilePath() async {
    Directory? storageDirectory = await getExternalStorageDirectory();
    String sdPath = storageDirectory!.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/audio_${i++}.mp3";
  }
}

class TextEntryPage extends StatefulWidget {
  @override
  _TextEntryPageState createState() => _TextEntryPageState();
}

class _TextEntryPageState extends State<TextEntryPage> {
  String _enteredText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // -сделал appbar прозрачным
      appBar: AppBar(
        backgroundColor: Colors.transparent, // -добавил строку
        elevation: 0,), // -и эту
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите текст для анализа', style: TextStyle(fontSize: 15)), // -стилёк
            SizedBox(height: 100), // -размер
            // Поле для ввода текста
            TextFormField(

              // -от сих
              decoration: InputDecoration(
                labelText: '   Пишите здесь',
              ),
              // -до сих

              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
            ),
            SizedBox(height: 40), // -размер
            ElevatedButton(
              onPressed: () {
                // При нажатии на кнопку "Отправить" отправляем текст на анализ и переходим на предыдущую страницу.
                Navigator.pop(context);
              },

              // -добавил кусок ниже
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 160, vertical: 24),
                textStyle: TextStyle(fontSize: 15),
                primary: Color.fromARGB(255, 24, 24, 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                onPrimary: Colors.white, //-строчкка нужная
              ), // -до сюда

              child: Text('Отправить'),
            ),
          ],
        ),
      ),
    );
  }
}