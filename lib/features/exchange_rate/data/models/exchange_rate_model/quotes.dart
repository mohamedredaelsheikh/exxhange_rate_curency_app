class Quotes {
  Map<String, Map<String, double>>? dates;

  Quotes({this.dates});

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      dates: json.map(
        (date, rates) => MapEntry(
          date,
          (rates as Map<String, dynamic>).map(
            (currencyPair, rate) =>
                MapEntry(currencyPair, (rate as num).toDouble()),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return dates ?? {};
  }
}
