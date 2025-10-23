class StatesResponse {
  const StatesResponse({required this.states});

  final List<String> states;

  factory StatesResponse.fromJson(Map<String, dynamic> json) {
    final statesData = json['data']?['states'] as List? ?? [];
    return StatesResponse(
      states: statesData.map((e) => e['name'] as String).toList(),
    );
  }
}
