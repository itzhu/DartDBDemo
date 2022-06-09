import 'package:flutter/material.dart';
import 'package:flutter_db_creator_simple/app.dart';

import 'pages/page_main.dart';

void main() {
  App.getInstance().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}