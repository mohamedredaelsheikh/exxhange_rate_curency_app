import 'package:dartz/dartz.dart';
import 'package:exchange_rate_currency_app/core/errors/failures.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/entities/exchange_rate_entity.dart';

abstract class ExchangeRateRepo {
  Future<Either<Failure, ExchangeRate>> getExchangeRate(
    DateTime startDate,
    DateTime endDate,
    String baseCurrency,
    String targetCurrency,
  );
}
