import 'package:dartz/dartz.dart';
import 'package:exchange_rate_currency_app/core/errors/failures.dart';
import 'package:exchange_rate_currency_app/core/use_cases/use_case.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_paramters_model.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/entities/exchange_rate_entity.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/repos/exchange_rate_repo.dart';

class GetExchangeRateUseCase
    extends UseCase<ExchangeRate, ExchangeRateParamtersModel> {
  final ExchangeRateRepo exchangeRateRepo;

  GetExchangeRateUseCase(this.exchangeRateRepo);
  @override
  Future<Either<Failure, ExchangeRate>> call(
    ExchangeRateParamtersModel param,
  ) async {
    return await exchangeRateRepo.getExchangeRate(
      param.startDate,
      param.endDate,
      param.baseCurrency,
      param.targetCurrency,
    );
  }
}
