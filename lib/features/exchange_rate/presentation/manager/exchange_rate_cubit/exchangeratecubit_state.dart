part of 'exchangeratecubit_cubit.dart';

sealed class ExchangeratecubitState extends Equatable {
  const ExchangeratecubitState();

  @override
  List<Object> get props => [];
}

final class ExchangeratecubitInitial extends ExchangeratecubitState {}

final class ExchangeratecubitLoading extends ExchangeratecubitState {}

final class ExchangeratecubitSuceess extends ExchangeratecubitState {
  final ExchangeRate exchangeRate;
  final int currentpage;

  const ExchangeratecubitSuceess({
    required this.exchangeRate,
    this.currentpage = 0,
  });

  @override
  List<Object> get props => [exchangeRate, currentpage];
}

final class ExchangeratecubitFailure extends ExchangeratecubitState {
  final String errorMessage;
  const ExchangeratecubitFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
