import 'package:flutter/material.dart';
import './home_page.dart';
import './chat_page.dart';
import './profile_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    ChatPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Главная'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Чат'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Профиль'),
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
