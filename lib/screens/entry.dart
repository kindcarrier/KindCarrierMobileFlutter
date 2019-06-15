import 'package:flutter/material.dart';
import 'package:kind_carrier/components/auth/button.dart';
import 'package:kind_carrier/screens/login.dart';

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

  goToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInScreen()));
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
                title: 'Регистрация',
                onPress: () {},
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                title: 'Войти',
                onPress: this.goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
