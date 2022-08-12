import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swish006/screens/auth/LogIn_page.dart';
import 'package:swish006/screens/auth/Register_page.dart';
import 'package:swish006/screens/home/homeScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Swish Basketball';
  static const ColorScheme colorscheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.orange,
      onPrimary: Colors.orange,
      secondary: Colors.black87,
      onSecondary: Colors.black45,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white70,
      onBackground: Colors.white70,
      surface: Colors.white,
      onSurface: Colors.white);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
            //buttonTheme: const ButtonThemeData(shape: RoundedRectangleBorder(),)),
            primaryColor: Colors.orange,
            backgroundColor: Colors.orange,
            buttonTheme: const ButtonThemeData(colorScheme: colorscheme)),
        initialRoute: '/',
        routes: {
          '/': (context) => const FirstScreen(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LogInPage(),
          '/home': (context) => const HomeScreen()
        });
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('SWISH')),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Log In'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Register'),
              )
            ],
          ),
        )));
  }
}
