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

    Timer(Duration(seconds: 2), () => checkLoginstatus());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/loginBackround.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Image.asset("assets/loginimage.png"),
              ),
              Center(
                child: Text(
                  "TODO APP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(top: 500),
          child: Center(child:CircularProgressIndicator(color: Colors.white,)),
        )
      ],
    );
  }

  void checkLoginstatus() {
    if (sharedpreferencesHelper.prefs?.getBool("LoginStatus") != null) {
      if (sharedpreferencesHelper.prefs!.getBool("LoginStatus")!) {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } else {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
