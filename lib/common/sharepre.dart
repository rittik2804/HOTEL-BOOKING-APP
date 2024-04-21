
import 'package:shared_preferences/shared_preferences.dart';

// class SharePre {
//   // save data in local
//
//   static setUserId(String userId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('user_id', userId);
//   }
//
// }


class GetUserDetail{
  Future<void>  setUserData(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future<String> getUserData(key)async{
    final prefs = await SharedPreferences.getInstance();
    String? text= prefs.getString(key);
    print("share pre -------------------------- $text");
    return text.toString() ;
  }
  remove(key)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
  Future<void>  setUserName(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
  Future<void>  setUserphone(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
  Future<void>  setUseremail(key , text )async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }
}