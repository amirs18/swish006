import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Enter Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Enter password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        )));
  }
}
