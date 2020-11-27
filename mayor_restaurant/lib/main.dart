import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mayor_restaurant/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffA80003),
        statusBarColor: Color(0xffA80003) 
      )
    );
    return MaterialApp(
      title: 'RESTAURANT',
      home: LoginPageState(),
    );
  }
}