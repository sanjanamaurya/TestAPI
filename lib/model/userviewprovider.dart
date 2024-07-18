import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapi/model/usermodel.dart';

class UserViewProvider with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.id.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return UserModel(id: token.toString());
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
  Future<bool> setString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(key, value);
    return true;
  }

  Future<String?> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
}