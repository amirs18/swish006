import 'package:flutter/material.dart';
import 'package:swish006/screens/auth/auth.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Enter Email',
              ),
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
                labelText: 'Enter password',
              ),
              controller: passwordController,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              onPressed: () => auth().registerWithEmail(
                  emailController.text, passwordController.text),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        )));
  }
}
