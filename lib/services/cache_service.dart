import 'package:flutter_covid_app/models/endpoint_data.dart';
import 'package:flutter_covid_app/models/endpoints_data.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  final SharedPreferences sharedPreferences;

  CacheService({required this.sharedPreferences});

  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';

  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';

  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
        endpointValueKey(endpoint),
        endpointData.value,
      );
      await sharedPreferences.setString(
        endpointDateKey(endpoint),
        endpointData.date.toIso8601String(),
      );
    });
  }

  EndpointsData getData() {
    Map<Endpoint, EndpointData> values = {};
    for (var endpoint in Endpoint.values) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString =
          sharedPreferences.getString(endpointDateKey(endpoint)) ?? '';
      final date = DateTime.tryParse(dateString);
      if (value != null && date != null) {
        values[endpoint] = EndpointData(value: value, date: date);
      }
    }
    return EndpointsData(values: values);
  }
}
