import 'package:flutter_covid_app/widgets/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  final String title;
  final String assetName;
  final Color color;

  EndpointCardData({
    required this.title,
    required this.assetName,
    required this.color,
  });
}

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  const EndpointCard({Key? key, required this.endpoint, required this.value})
      : super(key: key);

  static final Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases: EndpointCardData(
      title: 'Total',
      assetName: 'images/count.png',
      color: Colors.deepOrange,
    ),
    Endpoint.casesSuspected: EndpointCardData(
      title: 'Suspected',
      assetName: 'images/suspected.png',
      color: Colors.lightBlueAccent,
    ),
    Endpoint.casesConfirmed: EndpointCardData(
      title: 'Confirmed',
      assetName: 'images/confirmed.png',
      color: Colors.amber,
    ),
    Endpoint.recovered: EndpointCardData(
      title: 'Recovered',
      assetName: 'images/recovered.png',
      color: Colors.lightGreen,
    ),
    Endpoint.deaths: EndpointCardData(
      title: 'Deaths',
      assetName: 'images/death.png',
      color: Colors.redAccent,
    ),
  };

  String get formattedValue {
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData?.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: cardData?.color),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        cardData?.assetName ?? 'images/default.png',
                      ),
                      color: cardData?.color,
                    ),
                    Text(
                      value == -1 ? '' : formattedValue,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: cardData?.color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
