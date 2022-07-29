import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swish006/tasks/taskFirestore.dart';

class taskCard extends StatefulWidget {
  taskCard({
    Key? key,
  }) : super(key: key);

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  static final db = FirebaseFirestore.instance;
  final _taskFirestore = taskFirestore(
    name: "100 makes",
    state: "in progress",
    description: "make 100 free throws",
    progress: 69,
  );

  final docRef = db
      .collection("users")
      .doc("test")
      .collection("user tasks")
      .withConverter(
        fromFirestore: taskFirestore.fromFriestore,
        toFirestore: (taskFirestore task_firestore, options) =>
            task_firestore.toFirestore(),
      )
      .doc("test");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
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
            child: const SizedBox(
              width: 300,
              height: 100,
              child: Text('taskFirestore.getdata('),
            ),
          ),
        ),
      ),
    );
  }
}
