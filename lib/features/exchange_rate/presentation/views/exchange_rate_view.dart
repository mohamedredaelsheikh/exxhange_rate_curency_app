import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/exchangerateviewbody.dart';
import 'package:flutter/material.dart';

class ExchangeRateView extends StatelessWidget {
  const ExchangeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rate Currency'),
        backgroundColor: Colors.teal,
      ),
      body: ExchangeRateViewBody(),
    );
  }
}
