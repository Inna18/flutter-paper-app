import 'package:flutter/material.dart';
import 'package:paper_app/models/trace.dart';
import 'package:intl/intl.dart';

class TraceItem extends StatelessWidget {
  const TraceItem({required this.trace, super.key});

  final Trace trace;

  String getColdChain(String key) {
    switch (key) {
      case 'ALL':
        return ColdChainType.all.name;
      case 'PHARMA':
        return ColdChainType.pharma.name;
      case 'FROZEN':
        return ColdChainType.frozen.name;
      case 'DEEP_FREEZE':
        return ColdChainType.deepFreeze.name;
      case 'ETC':
        return ColdChainType.etc.name;
      default:
        return '';
    }
  }

  String getInvoiceStatus(String key) {
    switch (key) {
      case 'READY':
        return InvoiceStatus.ready.name;
      case 'MOVING':
        return InvoiceStatus.moving.name;
      case 'DONE':
        return InvoiceStatus.done.name;
      case 'SHUTDOWN':
        return InvoiceStatus.shutdown.name;
      default:
        return '';
    }
  }

  String checkStatus(String name) {
    switch (name) {
      case 'DONE':
        return '완료';
      default:
        return '미완료';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '유형: ${getColdChain(trace.coldChainType)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('|'),
                        ),
                        Text(
                          '주문번호: ${trace.invoiceCode ?? '미등록'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '출고자: ${trace.username}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('|'),
                        ),
                        Text(
                          'S/N: ${trace.serialNumber}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                        Text(
                          '출발: ${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(trace.departureAt))}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '도착: ${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(trace.arrivalAt))}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '업로드: ${checkStatus(trace.status)}',
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          getInvoiceStatus(trace.status),
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
