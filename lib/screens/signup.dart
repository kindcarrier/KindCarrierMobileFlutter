import 'package:flutter/material.dart';
import 'package:kind_carrier/components/auth/button.dart';
import 'package:kind_carrier/components/auth/text_input.dart';
import 'package:kind_carrier/components/auth/title.dart' as AuthTitle;
import 'package:kind_carrier/api/auth.dart' as auth;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  bool inProgress = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/background.png'),
    );
  }

  void _submit() async {
    final form = _formKey.currentState;

    this.setState(() {
      inProgress = true;
    });

    if (form.validate()) {
      form.save();
      try {
        var nameList = _name
            .trim()
            .split(' ')
            .where((el) => el != '')
            .map((el) => el.trim())
            .toList();
        var firstName = nameList.first;
        nameList.removeAt(0);
        var lastName = nameList.join(' ');
        var response = await auth.signUp(
            email: _email,
            password: _password,
            firstName: firstName,
            lastName: lastName);
        if (response.statusCode == 201) {
          // If server returns an OK response, parse the JSON.
          // return Post.fromJson(json.decode(response.body));
        } else {
          var decoded = json.decode(response.body);
          print(response.body);
          throw Exception(decoded['message']);
        }
        print(response.body.toString());
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ошибка'),
                content: Text('$e'),
                actions: <Widget>[
                  FlatButton(
                    child: new Text('Ok'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            });
      }
    }

    this.setState(() {
      inProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              height: 450,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AuthTitle.Title(title: 'РЕГИСТРАЦИЯ'),
                    SizedBox(height: 30),
                    TextInput(
                      validator: _nameValidator,
                      onSaved: (val) => _name = val,
                      hintText: 'Ваши имя и фамилия',
                      labelText: 'Имя и фамилия',
                    ),
                    SizedBox(height: 10),
                    TextInput(
                      validator: _emailValidator,
                      onSaved: (val) => _email = val,
                      hintText: 'Email',
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10),
                    TextInput(
                      validator: _passwordValidator,
                      onSaved: (val) => _password = val,
                      hintText: 'Пароль',
                      labelText: 'Пароль',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    Button(
                      title: 'Войти',
                      onPress: !inProgress ? _submit : null,
                      width: 250,
                    ),
                    inProgress
                        ? Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              CircularProgressIndicator(),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _nameValidator(String value) {
    return value.trim().split(' ').length < 2 ? 'Минимум 2 слова' : null;
  }

  String _passwordValidator(value) {
    return value.length < 6 ? 'Пароль должен быть минимум 6 символов' : null;
  }

  String _emailValidator(value) {
    return !value.contains('@') ? 'Не валидный email.' : null;
  }
}
