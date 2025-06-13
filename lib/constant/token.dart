import 'package:shared_preferences/shared_preferences.dart';

class ConstraintToken {
  static Future<void> setToken(String token) async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    await _value.setString('token', token);
  }

  static Future<String> getToken() async {
    final SharedPreferences _value = await SharedPreferences.getInstance();
    return _value.getString('token') ?? "";
  }
}
