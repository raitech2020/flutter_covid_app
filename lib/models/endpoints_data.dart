import 'package:flutter_covid_app/models/endpoint_data.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';

class EndpointsData {
  final Map<Endpoint, EndpointData> values;

  EndpointsData({required this.values});

  EndpointData get cases => values[Endpoint.cases]!;

  EndpointData get casesSuspected => values[Endpoint.casesSuspected]!;

  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed]!;

  EndpointData get deaths => values[Endpoint.deaths]!;

  EndpointData get recovered => values[Endpoint.recovered]!;

  @override
  String toString() {
    return 'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
  }
}
