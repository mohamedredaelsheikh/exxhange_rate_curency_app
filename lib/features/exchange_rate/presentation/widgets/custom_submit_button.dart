import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/exchange_rate_cubit/exchangeratecubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsCubitCubit, InputsStateCubit>(
      builder: (context, inputsState) {
        final exchangeCubit = context.read<ExchangeRateCubit>();
        final isEnabled =
            inputsState is InputsUpdated &&
            inputsState.startDate != null &&
            inputsState.endDate != null &&
            inputsState.fromCurrency != null &&
            inputsState.toCurrency != null;
        return ElevatedButton(
          onPressed:
              isEnabled
                  ? () {
                    final updatedState = inputsState;
                    exchangeCubit.getExchangeRate(
                      startDate: updatedState.startDate!,
                      endDate: updatedState.endDate!,
                      fromCurrency: updatedState.fromCurrency!,
                      toCurrency: updatedState.toCurrency!,
                    );
                  }
                  : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}
