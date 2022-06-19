import 'package:flutter_covid_app/widgets/endpoint.dart';

const String sandboxKey =
    '15e8e97f88f866e9e9853b52af8cc42c51b604797808a2598f68b0079b995c25';

const String host = 'ncov2019-admin.firebaseapp.com';
const int port = 443;
const String basePath = 't/nubentos.com/ncovapi/1.0.0';

const Map<Endpoint, String> path = {
  Endpoint.cases: 'cases',
  Endpoint.casesConfirmed: 'casesConfirmed',
  Endpoint.casesSuspected: 'casesSuspected',
  Endpoint.deaths: 'deaths',
  Endpoint.recovered: 'recovered',
};

const Map<Endpoint, String> responseJsonKeys = {
  Endpoint.cases: 'cases',
  Endpoint.casesConfirmed: 'data',
  Endpoint.casesSuspected: 'data',
  Endpoint.deaths: 'data',
  Endpoint.recovered: 'data',
};
