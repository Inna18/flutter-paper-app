import 'dart:convert';
import 'package:paper_app/src/utils/token_utils.dart';
import 'package:paper_app/src/datasource/remote/login_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final LoginDataSource _loginDataSource = LoginDataSource();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<Map<String, dynamic>> login(String code, String otp) {
    return _loginDataSource.login(code, otp).then((value) {
      var jsonString = value.body;
      Map<String, dynamic> response = jsonDecode(jsonString);
      var token = response['data']['jwt'];
      var isValid = TokenUtils.isValid(token);
      if (isValid) {
        prefs.setString("token", token);
      }

      return response;
    });
  }
}
