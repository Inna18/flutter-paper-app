import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paper_app/src/controller/trace_controller.dart';
import 'package:paper_app/src/models/trace.dart';
import 'package:paper_app/src/screens/login.dart';
import 'package:paper_app/src/widgets/search_filter.dart';
import 'package:paper_app/src/widgets/traces_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class TracesScreen extends ConsumerStatefulWidget {
  const TracesScreen({super.key});

  @override
  ConsumerState<TracesScreen> createState() {
    return _TracesScreenState();
  }
}

class _TracesScreenState extends ConsumerState<TracesScreen> {
  var token;
  var firstLoad = true;

  @override
  void initState() {
    getToken();
    super.initState();
  }

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    final traceList = ref.watch(traceNotifierProvider);

    void fetchTrace(Map<String, String> params) {
      ref.read(traceNotifierProvider.notifier).fetchTrace(params);
    }

    if (firstLoad) {
      if (token != '') {
        firstLoad = false;
        Map<String, String> params = {
          'periodType': 'DEPARTURE_DATE',
          'startDate': '1900-01-01',
          'endDate': '2024-10-23',
          'coldChainType': '',
          'keyword': '',
          'page': '0',
          'size': '10',
        };
        fetchTrace(params);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      }
    }

    void showSearchFilter() {
      showTopModalSheet(
        context,
        SearchFilter(fetchTrace: fetchTrace),
        backgroundColor: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      );
    }

    void logout() {
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소')),
                TextButton(
                  child: const Text('확인'),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                  },
                )
              ],
            );
          });
    }

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
                onPressed: () => logout(),
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
                                    onPressed: () => showSearchFilter(),
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
                            '총 ${traceList.length}건',
                            textAlign: TextAlign.start,
                          ),
                          Expanded(
                              child: TracesList(traceList: traceList.toList())),
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
