import 'package:paper_app/src/models/trace.dart';
import 'package:paper_app/src/repository/trace_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class TraceController extends Notifier<Set<Trace>> {
  final TraceRepository _traceRepository = TraceRepository();
  List<dynamic> traceList = [];

  @override
  Set<Trace> build() {
    return {...traceList};
  }

  void fetchTrace(Map<String, String> params) async {
    traceList = await _traceRepository.getTraceList(params);
    state = {...traceList};
  }
}

final traceNotifierProvider = NotifierProvider<TraceController, Set<Trace>>(() {
  return TraceController();
});
