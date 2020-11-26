import 'package:flutter/material.dart';
import 'components/home.dart';
import 'components/input.dart';
import 'components/sample.dart';
import 'common/common.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/Input': (context) => InputScreen(),
        '/Sample': (context) => SampleScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}

class InputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'input',
          style: Styles.smallerStyle,
        ),
      ),
      body: Input(),
      bottomNavigationBar: BottomNavigationBarInput(),
    );
  }
}

class SampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          'sample',
          style: Styles.smallerStyle,
        ),
      ),
      body: Sample(),
      bottomNavigationBar: BottomNavigationBarSample(),
    );
  }
}
