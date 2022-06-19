import 'package:flutter_covid_app/models/data_repository.dart';
import 'package:flutter_covid_app/screens/dashboard.dart';
import 'package:flutter_covid_app/services/api.dart';
import 'package:flutter_covid_app/services/api_service.dart';
import 'package:flutter_covid_app/services/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(CovidApp(sharedPreferences: sharedPreferences));
}

class CovidApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const CovidApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepository(
        apiService: ApiService(api: Api.sandbox()),
        cacheService: CacheService(sharedPreferences: sharedPreferences),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RAI Coronavirus Tracker App',
        theme: ThemeData.dark().copyWith(
          // scaffoldBackgroundColor: Color(0xFF101010),
          scaffoldBackgroundColor: Colors.teal,
          cardColor: const Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
