import 'package:flutter_covid_app/utils/constants.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';

class Api {
  final String apiKey;

  Api({required this.apiKey});

  factory Api.sandbox() => Api(apiKey: sandboxKey);

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        port: port,
        // path: '$basePath/${path[endpoint]}',
        path: '${path[endpoint]}',
      );
}
