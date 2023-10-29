import "package:get/get.dart";
import 'package:flutter/material.dart';
//import 'package:push_named/ScreenA.dart';
import 'screenA.dart';
import 'scrennB.dart';
import 'scrennC.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      routes: {
        '/':(context) => ScreenA(),
        '/b':(context) => ScreenB(),
        '/c':(context) => ScreenC()
      },
    );
  }
}
