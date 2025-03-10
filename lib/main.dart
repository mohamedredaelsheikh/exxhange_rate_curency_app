import 'package:dio/dio.dart';
import 'package:exchange_rate_currency_app/core/utils/api_service.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/data_sources/exchange_rate_repo_impl.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/use_cases/get_exchange_rate_use_case.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/exchange_rate_cubit/exchangeratecubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/views/exchange_rate_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ExchangeRateCurrencyApp());
}

class ExchangeRateCurrencyApp extends StatelessWidget {
  const ExchangeRateCurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InputsCubitCubit(), // Provide InputsCubit
        ),
        BlocProvider(
          create:
              (context) => ExchangeRateCubit(
                GetExchangeRateUseCase(ExchangeRateRepoImpl(ApiService(Dio()))),
              ), // Provide ExchangeRateCubit مع الـ Dependencies
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exchange Rate Currency App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
            accentColor: Colors.orange,
          ),

          scaffoldBackgroundColor: Colors.grey.shade100,
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: ExchangeRateView(),
      ),
    );
  }
}
