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

  void fetchTrace() async {
    traceList = await _traceRepository.getTraceList();
    state = {...traceList};
  }
}

final traceNotifierProvider = NotifierProvider<TraceController, Set<Trace>>(() {
  return TraceController();
});
