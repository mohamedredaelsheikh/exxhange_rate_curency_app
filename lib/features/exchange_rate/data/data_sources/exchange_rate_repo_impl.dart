import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exchange_rate_currency_app/core/errors/failures.dart';
import 'package:exchange_rate_currency_app/core/utils/api_service.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_model/exchange_rate_model.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_paramters_model.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/entities/exchange_rate_entity.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/repos/exchange_rate_repo.dart';

class ExchangeRateRepoImpl extends ExchangeRateRepo {
  final ApiService apiService;

  ExchangeRateRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ExchangeRate>> getExchangeRate(
    DateTime startDate,
    DateTime endDate,
    String baseCurrency,
    String targetCurrency,
  ) async {
    try {
      final params = ExchangeRateParamtersModel(
        startDate: startDate,
        endDate: endDate,
        baseCurrency: baseCurrency,
        targetCurrency: targetCurrency,
      );
      var response = await apiService.get(exchangeRateParamtersModel: params);
      ExchangeRateModel exchangeRateModel = ExchangeRateModel.fromJson(
        response,
      );
      if (exchangeRateModel.success != true) {
        return Left(
          ServerFailure(
            errormessage:
                'API returned unsuccessful response: ${response['error']?['info'] ?? 'Unknown error'}',
          ),
        );
      }
      final exchangeRateEntity = exchangeRateModel.toEntity();
      return Right(exchangeRateEntity);
    } on DioException catch (e) {
      // التعامل مع أخطاء الـ API
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errormessage: 'Unexpected error: $e'));
    }
  }
}
