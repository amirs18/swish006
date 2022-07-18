import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/logIn';

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
    );
  }
}
