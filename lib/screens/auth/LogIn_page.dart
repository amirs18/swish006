import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swish006/screens/auth/auth.dart';
import 'package:swish006/tasks/taskCard.dart';

import '../../tasks/taskFirestore.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/logIn';

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String emailController = "";
  String passwordController = "";
  static final db = FirebaseFirestore.instance;
  final city = <String, String>{
    "name": "Los Angeles",
    "state": "CA",
    "country": "USA"
  };

  @override
  Widget build(BuildContext context) {
    User? user;
    Map<String, String> userEmail;
    return Scaffold(
        appBar: AppBar(
          title: Text('login'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)),
                    labelText: 'Enter Email',
                  ),
                  onChanged: ((value) => emailController = value)),
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
                  onChanged: ((value) => passwordController = value)),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size.fromHeight(50), // NEW
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                onPressed: () async => {
                  await auth.signInWithEmail(
                      emailController, passwordController),
                  user = FirebaseAuth.instance.currentUser,
                  userEmail = <String, String>{"name": user!.email.toString()},
                  db.collection('users').doc(user?.uid).set(userEmail),
                  if (user != null) Navigator.pushNamed(context, '/home')
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        )));
  }
}
