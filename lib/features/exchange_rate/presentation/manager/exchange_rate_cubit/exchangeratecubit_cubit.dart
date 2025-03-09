import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_paramters_model.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/entities/exchange_rate_entity.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/use_cases/get_exchange_rate_use_case.dart';

part 'exchangeratecubit_state.dart';

class ExchangeratecubitCubit extends Cubit<ExchangeratecubitState> {
  ExchangeratecubitCubit() : super(ExchangeratecubitInitial());
}

class ExchangeRateCubit extends Cubit<ExchangeratecubitState> {
  final GetExchangeRateUseCase getExchangeRateUseCase;

  ExchangeRateCubit(this.getExchangeRateUseCase)
    : super(ExchangeratecubitInitial());

  Future<void> getExchangeRate({
    required DateTime startDate,
    required DateTime endDate,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    emit((ExchangeratecubitLoading()));

    final result = await getExchangeRateUseCase(
      ExchangeRateParamtersModel(
        startDate: startDate,
        endDate: endDate,
        baseCurrency: fromCurrency,
        targetCurrency: toCurrency,
      ),
    );

    result.fold(
      (failure) =>
          emit(ExchangeratecubitFailure(errorMessage: failure.errormessage)),
      (exchangeRate) => emit(
        ExchangeratecubitSuceess(exchangeRate: exchangeRate, currentpage: 0),
      ),
    );
  }

  void updatePage(int newPage) {
    if (state is ExchangeratecubitSuceess) {
      final currentState = state as ExchangeratecubitSuceess;
      emit(
        ExchangeratecubitSuceess(
          exchangeRate: currentState.exchangeRate,
          currentpage: newPage,
        ),
      );
    }
  }
}
