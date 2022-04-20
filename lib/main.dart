import 'package:flutter/material.dart';
import 'package:pharmainc/presentation/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharma Inc',
      theme: ThemeData(
scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.orange,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
            backgroundColor: Color(0xff003461),)
      ),
      home: const HomePage(),
    );
  }
}

