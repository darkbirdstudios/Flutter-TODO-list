



import 'package:shared_preferences/shared_preferences.dart';



class sharedpreferencesHelper{
  static SharedPreferences? prefs ;

  static getSharedPreferencesinstance()async{
    prefs = await SharedPreferences.getInstance();
  }

}
