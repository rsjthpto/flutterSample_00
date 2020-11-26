import 'package:flutter/material.dart';

//style
class Styles {
  static const mainStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 30,
      fontWeight: FontWeight.w200,
      color: Colors.black);

  static const subStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 25,
      fontWeight: FontWeight.w200,
      color: Colors.black);

  static const modalStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 22,
      fontWeight: FontWeight.w200,
      color: Colors.black);

  static const smallerStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.w200,
      color: Colors.black);
}

//bottomNavigationBar
class BottomNavigationBarInput extends StatelessWidget {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('home'),
          icon: Icon(
            Icons.home,
            color: Colors.black54,
          ),
        ),
        BottomNavigationBarItem(
          title: Text('sample'),
          icon: Icon(Icons.list, color: Colors.black54),
        ),
      ],
      onTap: (int _currentIndex) {
        if (_currentIndex == 0) Navigator.pushNamed(context, '/');
        if (_currentIndex == 1) Navigator.pushNamed(context, '/Sample');
      },
    );
  }
}

class BottomNavigationBarSample extends StatelessWidget {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('back'),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        BottomNavigationBarItem(
          title: Text('home'),
          icon: Icon(Icons.home, color: Colors.black54),
        ),
      ],
      onTap: (int _currentIndex) {
        if (_currentIndex == 0) Navigator.pop(context);
        if (_currentIndex == 1) Navigator.pushNamed(context, '/');
      },
    );
  }
}
