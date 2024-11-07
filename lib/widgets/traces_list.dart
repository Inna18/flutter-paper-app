import 'package:flutter/material.dart';
import 'package:paper_app/models/trace.dart';
import 'package:paper_app/widgets/trace_item.dart';

class TracesList extends StatelessWidget {
  const TracesList({required this.traceList, super.key});

  final List<dynamic> traceList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: traceList.length,
      itemBuilder: (context, index) => TraceItem(trace: traceList[index]),
    );
  }
}
