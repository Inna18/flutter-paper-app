enum ColdChainType {
  all('전체'),
  pharma('냉장'),
  frozen('냉동1'),
  deepFreeze('냉동2'),
  etc('사용자 설정');

  final String name;
  const ColdChainType(this.name);
}

enum InvoiceStatus {
  ready('활성'),
  moving('이동'),
  done('도착'),
  shutdown('강제 종료');

  final String name;
  const InvoiceStatus(this.name);
}

enum SearchPeriodType {
  departureAt('DEPARTURE_DATE'),
  arrivalAt('ARRIVAL_DATE');

  final String name;
  const SearchPeriodType(this.name);
}

class Trace {
  const Trace({
    required this.id,
    required this.txId,
    required this.operator,
    required this.transporter,
    required this.username,
    required this.serialNumber,
    required this.groupName,
    required this.invoiceCode,
    required this.coldChainType,
    required this.status,
    required this.loggingStatus,
    required this.loggingMode,
    required this.eventCount,
    required this.battery,
    required this.departureAt,
    required this.arrivalAt,
    required this.serviceClientName,
    required this.deviceModelCode,
    required this.deviceName,
    required this.deviceMode,
  });

  final String id;
  final String txId;
  final String operator;
  final String transporter;
  final String username;
  final String serialNumber;
  final dynamic groupName;
  final dynamic invoiceCode;
  final String coldChainType;
  final String status;
  final String loggingStatus;
  final String loggingMode;
  final int eventCount;
  final int battery;
  final dynamic departureAt;
  final dynamic arrivalAt;
  final dynamic serviceClientName;
  final dynamic deviceModelCode;
  final String deviceName;
  final dynamic deviceMode;

  factory Trace.fromJson(Map<String, dynamic> json) {
    print(json);
    return Trace(
      id: json['id'],
      txId: json['txId'],
      operator: json['operator'],
      transporter: json['transporter'],
      coldChainType: json['coldChainType'],
      invoiceCode: json['invoiceCode'],
      status: json['status'],
      username: json['username'],
      serialNumber: json['serialNumber'],
      groupName: json['groupName'],
      departureAt: json['departureAt'],
      arrivalAt: json['arrivalAt'],
      loggingStatus: json['loggingStatus'],
      loggingMode: json['loggingMode'],
      eventCount: json['eventCount'],
      battery: json['battery'],
      serviceClientName: json['serviceClientName'],
      deviceModelCode: json['deviceModelCode'],
      deviceName: json['deviceName'],
      deviceMode: json['deviceMode'],
    );
  }
}
