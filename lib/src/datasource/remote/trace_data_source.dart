import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paper_app/src/models/trace.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraceDataSource {
  Future<List<dynamic>> getTraceList() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    var token = await prefs.getString('token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Verify': token!
    };
    Map<String, String> params = {
      'periodType': 'DEPARTURE_DATE',
      'startDate': '1900-01-01',
      'endDate': '2024-10-23',
      'coldChainType': '',
      'keyword': '',
      'page': '0',
      'size': '10',
      // 'sort': 'createdAt,departureAt,desc',
    };
    var uri = Uri.parse('http://192.168.0.31:9000/api/paper/trace')
        .replace(queryParameters: params);
    final response = await http.get(uri, headers: headers);
    var jsonResponse = json.decode(response.body);
    var list = jsonResponse['data']['list'];
    List<dynamic> traces = list.map((json) => Trace.fromJson(json)).toList();
    
    return traces;
  }
}
