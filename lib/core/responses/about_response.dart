/// Model class used for the GET /mock/about request.
class AboutResponse {
  String message = '';

  DateTime createdAt = DateTime.fromMicrosecondsSinceEpoch(0);

  AboutResponse({
    required this.message,
    required this.createdAt,
  });

  factory AboutResponse.fromJson(Map<String, dynamic> json) => AboutResponse(
        message: json['message'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
