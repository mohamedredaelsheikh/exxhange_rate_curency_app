import 'package:dio/dio.dart';
import 'package:exchange_rate_currency_app/core/constants/api_constant.dart';
import 'package:exchange_rate_currency_app/core/utils/functions/format_dates.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_paramters_model.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = ApiConstants.baseUrl;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required ExchangeRateParamtersModel exchangeRateParamtersModel,
  }) async {
    var response = await _dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.timeframeEndpoint}',
      queryParameters: {
        'start_date': formatDate(exchangeRateParamtersModel.startDate),
        'end_date': formatDate(exchangeRateParamtersModel.endDate),
        'source': exchangeRateParamtersModel.baseCurrency,
        'currencies': exchangeRateParamtersModel.targetCurrency,
        'access_key': ApiConstants.accessKey,
      },
    );
    return response.data;
  }
}
