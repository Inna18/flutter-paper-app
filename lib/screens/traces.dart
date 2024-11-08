import 'package:flutter/material.dart';
import 'package:paper_app/screens/login.dart';
import 'package:paper_app/widgets/search_filter.dart';
import 'package:paper_app/widgets/traces_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void _logout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('로그아웃 하시겠습니까?')],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
                  prefs.remove('token');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                },
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('배송조회'),
          backgroundColor: const Color.fromRGBO(1, 20, 57, 1),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(60, 30),
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: const BorderSide(
                        color: Color.fromRGBO(43, 87, 173, 1))),
                onPressed: () => _logout(),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(color: Color.fromRGBO(139, 177, 235, 1)),
                ),
              ),
            )
          ],
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
