import 'dart:convert';

import 'package:flutter_covid_app/models/endpoint_data.dart';
import 'package:flutter_covid_app/services/api.dart';
import 'package:flutter_covid_app/utils/constants.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final Api api;

  ApiService({required this.api});

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String accessToken = data['access_token'];
      return accessToken;
    }
    print('Request ${api.tokenUri()} failed.\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndpointData> getEndpointData(
      {required String token, required Endpoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final int value = data[0][responseJsonKeys[endpoint]];
        final String dateString = data[0]['date'];
        final date = DateTime.tryParse(dateString)!;
        return EndpointData(value: value, date: date);
      }
    }
    print('Request $uri failed.\n Response: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
