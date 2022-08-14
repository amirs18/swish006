// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swish006/tasks/taskCard.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/logIn';

  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
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
  String loginE = '';

  Future<UserCredential?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          loginE = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          loginE = 'Wrong password provided for that user.';
        });
      } else {
        setState(() {
          loginE = e.message!;
        });
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    User? user;
    Map<String, String> userEmail;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
                height: 15,
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
                height: 15,
              ),
              Expanded(
                child: SizedBox(
                  height: 15,
                  child: Text(
                    loginE,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    minimumSize: const Size.fromHeight(50), // NEW
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                onPressed: () async => {
                  if (emailController != '' && passwordController != '')
                    {
                      await signInWithEmail(
                          email: emailController, password: passwordController),
                      user = FirebaseAuth.instance.currentUser,
                      if (user != null)
                        {
                          userEmail = <String, String>{
                            "name": user!.email.toString()
                          },
                          db.collection('users').doc(user?.uid).set(userEmail),
                          Navigator.pushNamed(context, '/home')
                        }
                    }
                  else
                    {
                      setState(() {
                        loginE = 'please insert values';
                      })
                    },
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: 'Forgot Your Password? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text: 'Reset',
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: emailController);
                          setState(() {
                            loginE = 'Password reset email sentx.';
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            setState(() {
                              loginE = 'Invalid email adress.';
                            });
                          } else if (e.code == 'missing-email') {
                            setState(() {
                              loginE = 'Please enter Email.';
                            });
                          } else {
                            setState(() {
                              loginE = e.message!;
                            });
                          }
                          //TODO add password reset
                        }
                      }),
              ]))
            ],
          ),
        )));
  }
}
