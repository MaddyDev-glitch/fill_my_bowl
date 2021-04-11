import 'package:fillmybowl1/LoginPage.dart';
import 'package:fillmybowl1/alreadylogged.dart';
import 'package:fillmybowl1/gotsupply.dart';
import 'package:fillmybowl1/homePage.dart';
import 'package:fillmybowl1/loading.dart';
import 'package:fillmybowl1/spotted.dart';
import 'package:fillmybowl1/spotted_cold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool already_sign_in = false;
CheckloggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int intValue = prefs.getInt('intValue');
  if (intValue == 1) {
    already_sign_in = true;
    print("true");
  } else {
    already_sign_in = false;
    print("false");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CheckloggedIn();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:(already_sign_in)?AlreadyLoginPage():LoginPage()
      // home:AlreadyLoginPage()

      , //CHANGE TESTER  1. LoginPage() 2.Spotted() 3. GotSupply()
    );
  }
}
