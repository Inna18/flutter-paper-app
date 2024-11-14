import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginDataSource {
  
  Future<http.Response> login(String code, String otp) async {
    var uri = Uri.parse('http://192.168.0.31:9000/api/paper/verify');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Map data = {'code': code, 'otp': otp};
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    return response;
  }
}
