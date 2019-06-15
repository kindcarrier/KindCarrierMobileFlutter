import 'package:flutter/material.dart';
import 'package:kind_carrier/components/auth/button.dart';
import 'package:kind_carrier/screens/login.dart';
import 'package:kind_carrier/screens/signup.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/background.png'),
    );
  }

  goToLogIn() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInScreen()));
  }

  goToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        width: size.width,
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Button(
                title: 'РЕГИСТРАЦИЯ',
                onPress: goToSignUp,
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                title: 'ВОЙТИ',
                onPress: goToLogIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
