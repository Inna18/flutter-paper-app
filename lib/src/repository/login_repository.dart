import 'dart:convert';

import 'package:paper_app/src/datasource/remote/login_data_source.dart';

class LoginRepository {
  final LoginDataSource _loginDataSource = LoginDataSource();

  Future<Map<String, dynamic>> login(String code, String otp) {
    return _loginDataSource.login(code, otp).then((value) {
      var jsonString = value.body;
      Map<String, dynamic> response = jsonDecode(jsonString);
      return response;
    });
  }
}
