import 'package:cloud_firestore/cloud_firestore.dart';

class TaskFirestore {
  final String? name;
  final String? state;
  final String? description;
  final int? progress;

  TaskFirestore({
    this.name,
    this.state,
    this.description,
    this.progress,
  });
  factory TaskFirestore.fromFriestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskFirestore(
      name: data?['name'],
      state: data?['state'],
      description: data?['description'],
      progress: data?['progress'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (description != null) "description": description,
      if (progress != null) "progress": progress
    };
  }

  static Future<String?> getName(String user, String task) async {
    final db = FirebaseFirestore.instance;
    final docRef = db
        .collection("users")
        .doc(user)
        .collection("user tasks")
        .withConverter(
          fromFirestore: TaskFirestore.fromFriestore,
          toFirestore: (TaskFirestore task_firestore, options) =>
              task_firestore.toFirestore(),
        )
        .doc(task);
    final docSnapshot = await docRef.get();
    final tf = docSnapshot.data();
    final result = tf?.name;
    return result;
  }
}
