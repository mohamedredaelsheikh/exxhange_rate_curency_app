class ExchangeRateParamtersModel {
  final DateTime startDate;
  final DateTime endDate;
  final String baseCurrency;
  final String targetCurrency;

  ExchangeRateParamtersModel({
    required this.startDate,
    required this.endDate,
    required this.baseCurrency,
    required this.targetCurrency,
  });
}
