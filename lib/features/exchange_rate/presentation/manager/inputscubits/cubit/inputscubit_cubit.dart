import 'package:exchange_rate_currency_app/features/exchange_rate/presentation/manager/inputscubits/cubit/inputscubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputsCubitCubit extends Cubit<InputsStateCubit> {
  InputsCubitCubit() : super(InputsInitial());

  void updateDates(DateTime? startDate, DateTime? endDate) {
    final currentState = state is InputsUpdated ? state as InputsUpdated : null;
    emit(
      InputsUpdated(
        startDate: startDate ?? currentState?.startDate,
        endDate: endDate ?? currentState?.endDate,
        fromCurrency: currentState?.fromCurrency,
        toCurrency: currentState?.toCurrency,
      ),
    );
    // print('New State: $newState');
    // emit(newState);
  }

  void updateCurrencies(String? fromCurrency, String? toCurrency) {
    final currentState = state is InputsUpdated ? state as InputsUpdated : null;
    emit(
      InputsUpdated(
        startDate: currentState?.startDate,
        endDate: currentState?.endDate,
        fromCurrency: fromCurrency ?? currentState?.fromCurrency,
        toCurrency: toCurrency ?? currentState?.toCurrency,
      ),
    );
  }
}
