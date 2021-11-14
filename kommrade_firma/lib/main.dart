
import 'package:flutter/material.dart';
import 'package:kommrade_firma/screens/login_screen.dart';
import 'package:custom_splash/custom_splash.dart';



void main() {
  Function duringSplash = () {
    int a = 123 + 23;

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: MyApp(), 2: MyApp()};

  runApp(MaterialApp(
    home: CustomSplash(
      imagePath: 'assets/images/logo.png',
      backGroundColor: Colors.grey,
      animationEffect: 'top-down',
      logoSize: 150,
      home: MyApp(),
      customFunction: duringSplash,
      duration: 2500,
      type: CustomSplashType.StaticDuration,
      outputAndHome: op,
    ),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furtherep Company',
      theme: ThemeData(
        primaryColor:  Color.fromRGBO(10,39,97,1),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("GİRİŞ YAP"),
          centerTitle: true,
        ),
        
        body: LoginScreen(),
        
      ),
      
    );
  }
}

