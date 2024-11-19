import 'package:paper_app/src/datasource/remote/trace_data_source.dart';

class TraceRepository {
  final TraceDataSource _traceDataSource = TraceDataSource();

  Future<List<dynamic>> getTraceList(Map<String, String> params) {
    return _traceDataSource.getTraceList(params);
  }
}
