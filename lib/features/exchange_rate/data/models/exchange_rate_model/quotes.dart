class Quotes {
  Map<String, dynamic>? dates;

  Quotes({this.dates});

  // From JSON to Quotes object
  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      dates: json, // Store the map directly as it is
    );
  }

  // From Quotes object to JSON
  Map<String, dynamic> toJson() {
    return dates ?? {};
  }
}
