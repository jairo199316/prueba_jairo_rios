class CountriesResponse {
  const CountriesResponse({
    required this.countries,
  });

  final List<String> countries;

  factory CountriesResponse.fromJson(Map<String, dynamic> json) {
    final countries = (json['data'] as List?) ?? [];

    return CountriesResponse(
      countries: countries.map((e) => e['country'] as String).toList(),
    );
  }
}
