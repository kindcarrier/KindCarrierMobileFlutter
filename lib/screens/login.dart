import 'package:flutter/material.dart';
import '../components/auth/button.dart';
import '../components/auth/text_input.dart';
import '../components/auth/title.dart' as AuthTitle;

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

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Alert'),
            content: Text('Email: $_email, password: $_password'),
          ));
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
    return value.length < 6 ? 'Password must be 6 character min.' : null;
  }

  String _emailValidator(value) {
    return !value.contains('@') ? 'Not a valid email.' : null;
  }
}
