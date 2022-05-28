// ignore_for_file: unnecessary_this

import 'package:covid_19/constant.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:covid_19/screens/info_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(bodyText1: TextStyle(color: kBodyTextColor)),
      ),
      home: const HomeScreen(),
    );
  }
}
