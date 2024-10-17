enum ColdChainType { pharma, frozen, deep_freeze, etc }

enum Status { ready, moving, done, shutdown }

class Trace {
  const Trace({
    required this.txId,
    required this.coldChainType,
    required this.invoiceCode,
    required this.status,
    required this.username,
    required this.serialNumber,
    required this.groupName,
    required this.departureAt,
    required this.arrivalAt,
    required this.loggingStatus,
  });

  final String txId;
  final ColdChainType coldChainType;
  final String invoiceCode;
  final Status status;
  final String username;
  final String serialNumber;
  final String groupName;
  final String departureAt;
  final String arrivalAt;
  final String loggingStatus;
}
