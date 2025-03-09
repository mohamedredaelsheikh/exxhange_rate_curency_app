import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_cubit.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePickerWidget extends StatelessWidget {
  final bool isStartDate;

  const DatePickerWidget({super.key, required this.isStartDate});

  Future<void> _selectDate(BuildContext context) async {
    final cubit = context.read<InputsCubitCubit>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      cubit.updateDates(
        isStartDate ? picked : null,
        isStartDate ? null : picked,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputsCubitCubit, InputsStateCubit>(
      builder: (context, state) {
        final date =
            state is InputsUpdated
                ? (isStartDate ? state.startDate : state.endDate)
                : null;
        return ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text(
            date != null
                ? date.toString().split(' ')[0]
                : (isStartDate ? 'Start Date' : 'End Date'),
          ),
        );
      },
    );
  }
}
