import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/entry.dart';
import './screens/signup.dart';
import './screens/login.dart';

void main() {
  runApp(KindCarrier());
}

class KindCarrier extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EntryScreen(),
        routes: {
          '/home': (BuildContext context) => HomeScreen(),
          '/signup': (BuildContext context) => SignUpScreen(),
          '/login': (BuildContext context) => LogInScreen(),
          '/entry': (BuildContext context) => EntryScreen(),
        },
      );
  }
}
