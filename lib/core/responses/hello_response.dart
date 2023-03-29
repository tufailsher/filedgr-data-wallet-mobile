/// Model class used for the GET /mock/hello request.
class HelloResponse {
  String name = '';

  String message = '';

  DateTime createdAt = DateTime.fromMicrosecondsSinceEpoch(0);

  HelloResponse({
    required this.name,
    required this.message,
    required this.createdAt,
  });

  factory HelloResponse.fromJson(Map<String, dynamic> json) => HelloResponse(
        name: json['name'],
        message: json['message'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
