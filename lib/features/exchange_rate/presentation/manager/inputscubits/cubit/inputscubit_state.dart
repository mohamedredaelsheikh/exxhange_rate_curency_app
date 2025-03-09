import 'package:equatable/equatable.dart';

abstract class InputsStateCubit extends Equatable {
  const InputsStateCubit();

  @override
  List<Object?> get props => [];
}

class InputsInitial extends InputsStateCubit {}

class InputsUpdated extends InputsStateCubit {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? fromCurrency;
  final String? toCurrency;

  const InputsUpdated({
    this.startDate,
    this.endDate,
    this.fromCurrency,
    this.toCurrency,
  });

  InputsUpdated copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? fromCurrency,
    String? toCurrency,
  }) {
    return InputsUpdated(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
    );
  }

  @override
  List<Object?> get props => [startDate, endDate, fromCurrency, toCurrency];
}
