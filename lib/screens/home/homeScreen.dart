// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:swish006/tasks/taskCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  static final db = FirebaseFirestore.instance;
  final docRef =
      db.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc('test') //TODO: add veribles
      .collection('user tasks')
      .snapshots();
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  List<Widget> get _widgetOptions => <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'לוח תוצאות',
            style: optionStyle,
            textDirection: TextDirection.rtl,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getNameFirestore,
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    //'בית, כאן יהיו התרגלים להיום, התקדמות וכאלה דברים',
                    style: optionStyle,
                    textDirection: TextDirection.rtl,
                  );
                })),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: stream(),
        )
        //  const Padding(

        //   padding: EdgeInsets.all(8.0),
        //   child: Text(
        //     'תרגילים כאן נכניס בנק תרגילים ואת "שיעורי הבית" שאתה נותן',
        //     style: optionStyle,
        //     textDirection: TextDirection.rtl,
        //   ),

        // ),
      ];

  Future<String> get getNameFirestore => docRef.get().then(
        //TODO: catch error
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return data['name'];
        },
        onError: (e) => print("Error getting document: $e"),
      );

  StreamBuilder<QuerySnapshot<Object?>> stream() {
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['name']),
                    subtitle: Text(data['state']),
                  );
                })
                .toList()
                .cast(),
          );
        });
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        title: const Center(child: Text('SWISH')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: Visibility(
        visible: (_selectedIndex == 2),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.orange, //TODO: Add Task
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: btnNavBar(),
    );
  }

  BottomNavigationBar btnNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'לוח',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_basketball),
          label: 'בית',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'תרגילים',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.deepOrange,
      onTap: _onItemTapped,
    );
  }
}
