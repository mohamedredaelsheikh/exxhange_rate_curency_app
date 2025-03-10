import 'package:exchange_rate_currency_app/core/widgets/custom_spring_wave.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/custom_currency_select.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/custom_date_picker_widget.dart';
import 'package:exchange_rate_currency_app/core/widgets/custom_error_message.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/custom_exchange_rate_table.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/custom_initial_widget.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/widgets/custom_submit_button.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/exchange_rate_cubit/exchangeratecubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRateViewBody extends StatelessWidget {
  const ExchangeRateViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Expanded(child: DatePickerWidget(isStartDate: true)),
                    SizedBox(width: 20),
                    Expanded(child: DatePickerWidget(isStartDate: false)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Expanded(
                      child: CurrencySelectorWidget(isFromCurrency: true),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CurrencySelectorWidget(isFromCurrency: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SubmitButtonWidget(),
            const SizedBox(height: 16),
            BlocBuilder<ExchangeRateCubit, ExchangeratecubitState>(
              builder: (context, state) {
                if (state is ExchangeratecubitInitial) {
                  return CustomInitialWidget();
                } else if (state is ExchangeratecubitLoading) {
                  return const CustomSpringWave();
                } else if (state is ExchangeratecubitFailure) {
                  return CustomErrorMessage(errormassage: state.errorMessage);
                } else if (state is ExchangeratecubitSuceess) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ExchangeRateTableWidget(),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
