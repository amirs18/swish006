// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swish006/tasks/taskFirestore.dart';

class TaskCard extends StatefulWidget {
  final String? user;
  final String? task;
  const TaskCard({Key? key, required this.user, required this.task})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  static final db = FirebaseFirestore.instance;
  final _taskFirestore = TaskFirestore(
    name: "100 makes",
    state: "in progress",
    description: "make 100 free throws",
    progress: 69,
  );

  User? user;

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    final docRef = db
        .collection('users')
        .doc(user?.uid)
        .collection("user tasks")
        .withConverter(
          fromFirestore: TaskFirestore.fromFriestore,
          toFirestore: (TaskFirestore taskFirestore, options) =>
              taskFirestore.toFirestore(),
        )
        .doc("test");
    return FutureBuilder<String?>(
        future: TaskFirestore.getName(user?.uid, 'test'),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () async {
                  //TODO: fix this get task from DB
                  await docRef.set(_taskFirestore);
                  final docSnapshot = await docRef.get();
                  final tf = docSnapshot.data();
                  if (tf != null) {
                    print(tf.name);
                  } else {
                    print("No such document.");
                  }
                  print('test');
                },
                child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Text(snapshot.data.toString())),
              ),
            ),
          );
        });
  }
}
