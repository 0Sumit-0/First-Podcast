import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/Screen/home_screen.dart';

import 'Screen/login_page.dart';
import 'Screen/playing_screen.dart';
import 'Screen/user.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/homescreen': (context)=>HomeScreen(),
        '/playscreen': (context) => PlayScreen(),
        '/userscreen':(context)=> UserPage(),
      },
    );
  }
}


