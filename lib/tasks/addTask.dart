// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  static const String routeName = '/AddTask';

  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
                height: 15,
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
              Expanded(child: SizedBox(height: 15, child: Text(''))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    minimumSize: const Size.fromHeight(50), // NEW
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24))),
                onPressed: () async {
                  if (true) {}
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
        ));
  }
}
