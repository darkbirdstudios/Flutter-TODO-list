import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list_sqlit/screens/DashboardScreen.dart';
import 'package:flutter_todo_list_sqlit/screens/LoginScreen.dart';
import 'package:flutter_todo_list_sqlit/utils/database/sharedpreferencesHelper.dart';


class SplashScreen extends StatefulWidget {
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 2),
            () =>checkLoginstatus());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("TODO APP", style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),),
      ),
    );
  }

  void checkLoginstatus() {
    if(sharedpreferencesHelper.prefs?.getBool("LoginStatus") != null)
    {
      if(sharedpreferencesHelper.prefs!.getBool("LoginStatus")!)
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardScreen()));
      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }else{
      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }


}


