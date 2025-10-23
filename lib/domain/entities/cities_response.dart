class CitiesResponse {
  const CitiesResponse({required this.cities});

  final List<String> cities;

  factory CitiesResponse.fromJson(Map<String, dynamic> json) {
    return CitiesResponse(
      cities: List<String>.from(json['data'] ?? []),
    );
  }
}
