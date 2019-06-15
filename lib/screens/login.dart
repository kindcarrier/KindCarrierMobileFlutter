import 'package:flutter/material.dart';
import 'package:kind_carrier/components/auth/button.dart';
import 'package:kind_carrier/components/auth/text_input.dart';
import 'package:kind_carrier/components/auth/title.dart' as AuthTitle;
import 'package:kind_carrier/api/login.dart' as loginApi;
import 'dart:convert';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/background.png'),
    );
  }

  void _submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      try {
        var response = await loginApi.logIn(_email, _password);
        if (response.statusCode == 200) {
          // If server returns an OK response, parse the JSON.
          // return Post.fromJson(json.decode(response.body));
        } else {
          var decoded = json.decode(response.body);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
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
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10),
                  TextInput(
                    validator: _passwordValidator,
                    onSaved: (val) => _password = val,
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Button(
                    title: 'Войти',
                    onPress: _submit,
                    width: 250,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _passwordValidator(value) {
    return value.length < 3 ? 'Password must be 6 character min.' : null;
  }

  String _emailValidator(value) {
    return !value.contains('@') ? 'Not a valid email.' : null;
  }
}
