import 'dart:io';

import 'package:flutter_covid_app/models/data_repository.dart';
import 'package:flutter_covid_app/models/endpoints_data.dart';
import 'package:flutter_covid_app/utils/date_formatter.dart';
import 'package:flutter_covid_app/widgets/endpoint.dart';
import 'package:flutter_covid_app/widgets/endpoint_card.dart';
import 'package:flutter_covid_app/widgets/last_updated_text.dart';
import 'package:flutter_covid_app/widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  EndpointsData? _endpointsData;

  @override
  void initState() {
    super.initState();
    final repo = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = repo.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final repo = Provider.of<DataRepository>(context, listen: false);
      final EndpointsData endpointsData = await repo.getAllEndpointsData();
      // call setState, so build is called
      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (e) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not connect to Server to retrieve data.\n $e',
        defaultActionText: 'Ok',
      );
    } catch (e) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try later.\n $e',
        defaultActionText: 'Ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = _endpointsData?.values[Endpoint.cases]?.date;
    final String updatedDateText;
    if (date != null) {
      final dateFormatter = DateFormatter(lastUpdatedDate: date);
      updatedDateText = dateFormatter.lastUpdatedDateText();
    } else {
      updatedDateText = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('RAI Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedText(
              text: updatedDateText,
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData?.values[endpoint]?.value ?? -1,
              ),
          ],
        ),
      ),
    );
  }
}
