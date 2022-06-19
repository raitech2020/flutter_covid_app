class EndpointData {
  final int value;
  final DateTime date;

  EndpointData({required this.value, required this.date});

  @override
  String toString() {
    return 'date: $date, value: $value\n';
  }
}
