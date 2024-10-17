import 'package:paper_app/models/trace.dart';

const currentTraces = [
  Trace(
    txId: '544c4b20-5820-3120-0060-e53e0f2eecf3',
    coldChainType: ColdChainType.etc,
    invoiceCode: '주문번호',
    status: Status.moving,
    username: '김인나',
    serialNumber: 'TLK-SPX1-006',
    groupName: '목적지',
    departureAt: '2023-10-13T13:45:04.008Z',
    arrivalAt: '2023-10-17T13:45:04.008Z',
    loggingStatus: 'MEASURING',
  ),
  Trace(
    txId: '544c4b20-5820-3120-0063-e382aad443fb',
    coldChainType: ColdChainType.etc,
    invoiceCode: '123',
    status: Status.shutdown,
    username: '김인나',
    serialNumber: 'TLK-SPX1-001',
    groupName: '목적지',
    departureAt: '2023-09-12T05:20:17.012691Z',
    arrivalAt: '2023-09-12T07:34:18.434572Z',
    loggingStatus: 'STOP',
  ),
  Trace(
    txId: '544c4b20-5820-3120-000b-d979ca60fa49',
    coldChainType: ColdChainType.pharma,
    invoiceCode: '0912T',
    status: Status.moving,
    username: '김인나',
    serialNumber: 'TLK-SPX1-016',
    groupName: '목적지',
    departureAt: '2023-08-30T02:08:00Z',
    arrivalAt: '2023-09-03T23:56:54.030821Z',
    loggingStatus: 'MEASURING',
  ),
];