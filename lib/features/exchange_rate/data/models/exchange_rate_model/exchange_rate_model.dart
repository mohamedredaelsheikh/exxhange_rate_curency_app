import 'package:exchange_rate_currency_app/features/exchange_rate/data/models/exchange_rate_model/quotes.dart';
import 'package:exchange_rate_currency_app/features/exchange_rate/domain/entities/exchange_rate_entity.dart';

class ExchangeRateModel {
  bool? success;
  String? terms;
  String? privacy;
  bool? timeframe;
  String? startDate;
  String? endDate;
  String? source;
  Quotes? quotes;

  ExchangeRateModel({
    this.success,
    this.terms,
    this.privacy,
    this.timeframe,
    this.startDate,
    this.endDate,
    this.source,
    this.quotes,
  });

  factory ExchangeRateModel.fromJson(Map<String, dynamic> json) {
    return ExchangeRateModel(
      success: json['success'] as bool?,
      terms: json['terms'] as String?,
      privacy: json['privacy'] as String?,
      timeframe: json['timeframe'] as bool?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      source: json['source'] as String?,
      quotes:
          json['quotes'] == null
              ? null
              : Quotes.fromJson(json['quotes'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'terms': terms,
    'privacy': privacy,
    'timeframe': timeframe,
    'start_date': startDate,
    'end_date': endDate,
    'source': source,
    'quotes': quotes?.toJson(),
  };

  ExchangeRate toEntity() {
    return ExchangeRate(dates: quotes?.dates ?? {});
  }
}
