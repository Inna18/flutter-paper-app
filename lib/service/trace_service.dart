import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:paper_app/models/trace.dart';

class TraceService {
  Future<List<dynamic>> getTraceList() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Verify':
          'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYTU5YWQyNC1hM2ZhLTQyY2QtOWMzZS1jNDk0OWNhOWFhMzMiLCJ0eXBlIjoiUEhBUk1BQ1kiLCJpYXQiOjE3Mjk2Njg0OTIsImV4cCI6MTcyOTY4MDQ5Mn0.YM3DBqgppMYgC0W_lr7_-gFbO2dsTGxmTSigJjk5_wk'
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
    var uri = Uri.parse('http://localhost:9000/api/paper/trace')
        .replace(queryParameters: params);
    final response = await http.get(uri, headers: headers);
    var jsonResponse = json.decode(response.body);
    var list = jsonResponse['data']['list'];
    List<dynamic> traces = list.map((json) => Trace.fromJson(json)).toList();
    return traces;
  }
}
