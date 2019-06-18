import 'package:flutter/material.dart';
import 'package:kind_carrier/components/auth/button.dart';
import 'package:kind_carrier/components/auth/text_input.dart';
import 'package:kind_carrier/components/auth/title.dart' as AuthTitle;
import 'package:kind_carrier/api/auth.dart' as auth;
import 'dart:convert';
import 'package:kind_carrier/models/user.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
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
        var response = await auth.logIn(email: _email, password: _password);
        if (response.statusCode == 200) {
          // If server returns an OK response, parse the JSON.
          var user = User.fromJson(json.decode(response.body));
          print(user.avatar.url);

          Navigator.of(context).pushNamed('/home');
        } else {
          var decoded = json.decode(response.body);
          throw Exception(decoded['message']);
        }
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
              height: 350,
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AuthTitle.Title(title: 'ВХОД'),
                    SizedBox(height: 30),
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

  String _passwordValidator(value) {
    return value.length < 3 ? 'Пароль должен быть 3 символа минимум' : null;
  }

  String _emailValidator(value) {
    return !value.contains('@') ? 'Невалидный email.' : null;
  }
}
