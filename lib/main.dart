import 'package:flutter/material.dart';
import 'package:flutter_todo_list_sqlit/screens/SplashScreen.dart';
import 'package:flutter_todo_list_sqlit/utils/database/sharedpreferencesHelper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedpreferencesHelper.getSharedPreferencesinstance();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}