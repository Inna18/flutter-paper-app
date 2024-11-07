import 'package:flutter/material.dart';
import 'package:paper_app/widgets/search_filter.dart';
import 'package:paper_app/widgets/traces_list.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:paper_app/service/trace_service.dart';

class TracesScreen extends StatefulWidget {
  const TracesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TracesScreenState();
  }
}

class _TracesScreenState extends State<TracesScreen> {
  TraceService traceService = TraceService();
  List<dynamic> traces = [];

  @override
  void initState() {
    _fetchTrace();
    super.initState();
  }

  void _fetchTrace() async {
    var traceList = await traceService.getTraceList();
    setState(() {
      traces = traceList;
    });
  }

  void _showSearchFilter() {
    showTopModalSheet(
      context,
      const SearchFilter(),
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('배송조회'),
          backgroundColor: const Color.fromRGBO(1, 20, 57, 1),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(1, 20, 57, 1)),
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(250, 252, 255, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    onPressed: () => _showSearchFilter(),
                                    child: Container(
                                      width: 500,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 8),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  161, 163, 179, 1)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('전체',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      161, 163, 179, 1))),
                                          Icon(
                                            Icons.search,
                                            color: Color.fromRGBO(
                                                161, 163, 179, 1),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Text(
                            '총 ${traces.length}건',
                            textAlign: TextAlign.start,
                          ),
                          Expanded(child: TracesList(traceList: traces)),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
