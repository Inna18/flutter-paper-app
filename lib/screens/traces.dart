import 'package:flutter/material.dart';
import 'package:paper_app/data/dummy_data.dart';
import 'package:paper_app/widgets/traces_list.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class TracesScreen extends StatefulWidget {
  const TracesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TracesScreenState();
  }
}

class _TracesScreenState extends State<TracesScreen> {
  void _showSearchFilter() {
    print('clicked');
    showTopModalSheet(
      context,
      Icon(
        Icons.abc,
        size: 100,
      ),
      backgroundColor: Colors.white,
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
                          TextButton(
                              onPressed: () => _showSearchFilter(),
                              child: Text('Search')),
                          Text(
                            '총 ${currentTraces.length}건',
                            textAlign: TextAlign.start,
                          ),
                          const Expanded(
                              child: TracesList(traceList: currentTraces)),
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
