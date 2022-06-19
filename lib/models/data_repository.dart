import 'package:flutter_covid_app/models/endpoint_data.dart';
import 'package:flutter_covid_app/models/endpoints_data.dart';
import 'package:flutter_covid_app/services/api_service.dart';
import 'package:flutter_covid_app/services/cache_service.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';
import 'package:http/http.dart';

class DataRepository {
  final ApiService apiService;
  final CacheService cacheService;
  String? _accessToken;

  DataRepository({required this.apiService, required this.cacheService});

  Future<EndpointData> getEndpointData(Endpoint endpoint) async {
    return await _getRefreshedData<EndpointData>(
      getData: () => apiService.getEndpointData(
        token: _accessToken!,
        endpoint: endpoint,
      ),
    );
  }

  Future<EndpointsData> getAllEndpointsData() async {
    final endpointsData = await _getRefreshedData<EndpointsData>(
      getData: _getAllEndpointsData,
    );
    cacheService.setData(endpointsData);
    return endpointsData;
  }

  EndpointsData getAllEndpointsCachedData() => cacheService.getData();

  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
        token: _accessToken!,
        endpoint: Endpoint.cases,
      ),
      apiService.getEndpointData(
        token: _accessToken!,
        endpoint: Endpoint.casesSuspected,
      ),
      apiService.getEndpointData(
        token: _accessToken!,
        endpoint: Endpoint.casesConfirmed,
      ),
      apiService.getEndpointData(
        token: _accessToken!,
        endpoint: Endpoint.deaths,
      ),
      apiService.getEndpointData(
        token: _accessToken!,
        endpoint: Endpoint.recovered,
      ),
    ]);
    return EndpointsData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      },
    );
  }

  Future<T> _getRefreshedData<T>({
    required Future<T> Function() getData,
  }) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await getData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        // unauthorized request, token has expired
        _accessToken = await apiService.getAccessToken();
        return await getData();
      }
      rethrow;
    }
  }
}
