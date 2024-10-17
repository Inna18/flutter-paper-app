import 'package:flutter/material.dart';
import 'package:paper_app/widgets/traces_list.dart';

class TracesScreen extends StatefulWidget {
  const TracesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TracesScreenState();
  }
}

class _TracesScreenState extends State<TracesScreen> {
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
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
