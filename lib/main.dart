import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/views/exchange_rate_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExchangeRateCurrencyApp());
}

class ExchangeRateCurrencyApp extends StatelessWidget {
  const ExchangeRateCurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchange Rate Currency App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExchangeRateView(),
    );
  }
}
