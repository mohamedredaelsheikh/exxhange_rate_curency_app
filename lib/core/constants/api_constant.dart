class ApiConstants {
  static const String baseUrl = 'https://api.exchangerate.host';
  static const String timeframeEndpoint = '/timeframe';
  static const String accessKey = 'fd94525e8f1caaec0e09e2b9a2742518';

  // Default currencies
  static const String defaultBaseCurrency = 'USD';
  static const List<String> supportedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'EGP',
    'CAD',
    'AUD',
    'CHF',
    'CNY',
    'INR',
  ];
}
