import 'package:exchange_rate_currency_app/core/constants/api_constant.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelectorWidget extends StatelessWidget {
  final bool isFromCurrency;

  const CurrencySelectorWidget({super.key, required this.isFromCurrency});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsCubitCubit, InputsStateCubit>(
      builder: (context, state) {
        final cubit = context.read<InputsCubitCubit>();
        final currency =
            state is InputsUpdated
                ? (isFromCurrency ? state.fromCurrency : state.toCurrency)
                : null;
        return DropdownButton<String>(
          value: currency,
          hint: Text(isFromCurrency ? 'From Currency' : 'To Currency'),
          isExpanded: true,
          items:
              ApiConstants.supportedCurrencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (newValue) {
            cubit.updateCurrencies(
              isFromCurrency ? newValue : null,
              isFromCurrency ? null : newValue,
            );
          },
        );
      },
    );
  }
}
