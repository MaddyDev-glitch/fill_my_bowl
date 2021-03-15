import 'package:fillmybowl1/LoginPage.dart';
import 'package:fillmybowl1/gotsupply.dart';
import 'package:fillmybowl1/homePage.dart';
import 'package:fillmybowl1/spotted.dart';
import 'package:fillmybowl1/spotted_cold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), //CHANGE TESTER  1. LoginPage() 2.Spotted() 3. GotSupply()
    );
        }}