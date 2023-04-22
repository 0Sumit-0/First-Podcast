import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/Screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:podcast/Services/SharedPreferences.dart';

import 'Screen/login_page.dart';
import 'Screen/playing_screen.dart';
import 'Screen/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isSignedIn=false;
  late String user;

  @override
  void initState(){
    super.initState();
    getUserLoggedInStatus();
    if(_isSignedIn==true){
      getUserLoggedInKey();
    }

  }

  getUserLoggedInKey()async {
    await HelperFunction.getUserLoggedInKey().then((value){
      user=value!;
    });
  }
  getUserLoggedInStatus()async{
    await HelperFunction.getUserLoggedInStatus().then((value){
      if(value!=null){
        _isSignedIn=value;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _isSignedIn? HomeScreen(userid: user) :LoginPage(),
        // '/homescreen': (context)=>HomeScreen(usermod: ,),
        '/playscreen': (context) => PlayScreen(index: 0,pod: null,),
        '/userscreen':(context)=> UserPage(),
      },
    );
  }
}

