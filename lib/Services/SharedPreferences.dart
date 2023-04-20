import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String userLoggedInKey=""; //user id
  static String userNameKey=""; //username or email

  // saving data to SF

  static Future<bool?> saveUserLoggeInStatus(bool isUserLoggedIn) async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey ,isUserLoggedIn);
  }
  static Future<bool?> saveUserName(String username) async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return await sf.setString(userNameKey ,username);
  }


  //get data from SF
  static Future<bool?> getUserLoggedInStatus() async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
  static Future<String?> getUserLoggedInKey() async{
    SharedPreferences sf= await SharedPreferences.getInstance();
    return sf.getString(userLoggedInKey);
  }

}