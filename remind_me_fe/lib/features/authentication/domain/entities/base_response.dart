class BaseResult {
  int httpStatusCode;
  String message;

  BaseResult({required this.httpStatusCode, required this.message});

  factory BaseResult.fromJson(Map<String, dynamic> json) {
    return BaseResult(
      httpStatusCode: json['httpStatusCode'] as int,
      message: json['message'] as String,
    );
  }
}
