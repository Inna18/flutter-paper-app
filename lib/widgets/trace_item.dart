import 'package:flutter/material.dart';
import 'package:paper_app/models/trace.dart';

class TraceItem extends StatelessWidget {
  const TraceItem({required this.trace, super.key});

  final Trace trace;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      color: Colors.white,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color.fromRGBO(117, 163, 226, 1))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                            '유형: ${trace.coldChainType.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('|'),
                        ),
                        SizedBox(
                          width: 134,
                          child: Text(
                            '주문번호: ${trace.invoiceCode}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                            '출고자: ${trace.username}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('|'),
                        ),
                        SizedBox(
                          width: 134,
                          child: Text(
                            'S/N: ${trace.serialNumber}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 224,
                          child: Text(
                            '목적지: ${trace.groupName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 224,
                          child: Text(
                            '출발: ${trace.departureAt}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 224,
                          child: Text(
                            '도착: ${trace.arrivalAt}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: Text(
                            '업로드: ${trace.loggingStatus}',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          trace.status.name,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(60, 30),
                                padding: const EdgeInsets.all(2),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    const Color.fromRGBO(76, 144, 239, 1),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {},
                            child: const Text('배송추적')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size(60, 30),
                                padding: const EdgeInsets.all(0),
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                foregroundColor:
                                    const Color.fromRGBO(161, 163, 179, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            onPressed: () {},
                            child: const Text('레포트'))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
