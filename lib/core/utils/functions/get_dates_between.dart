List<String> getDatesBetween(String startDate, String endDate) {
  DateTime start = DateTime.parse(startDate);
  DateTime end = DateTime.parse(endDate);
  List<String> result = [];
  while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
    result.add(start.toIso8601String().split("T")[0]);
    start = start.add(const Duration(days: 1));
  }
  return result;
}
