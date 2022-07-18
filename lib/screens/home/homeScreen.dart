import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'לוח תוצאות',
        style: optionStyle,
        textDirection: TextDirection.rtl,
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'בית, כאן יהיו התרגלים להיום, התקדמות וכאלה דברים',
        style: optionStyle,
        textDirection: TextDirection.rtl,
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'תרגילים כאן נכניס בנק תרגילים ואת "שיעורי הבית" שאתה נותן',
        style: optionStyle,
        textDirection: TextDirection.rtl,
      ),
    ),
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Center(child: Text('SWISH')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
