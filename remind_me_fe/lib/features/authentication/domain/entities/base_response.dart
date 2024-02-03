class BaseResponse {
  int httpStatusCode;
  String message;

  BaseResponse({required this.httpStatusCode, required this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      httpStatusCode: json['httpStatusCode'] as int,
      message: json['message'] as String,
    );
  }
}
