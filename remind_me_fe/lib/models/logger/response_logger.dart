class ResponeLogger {
  String message;
  int httpStatusCode;

  static const int createdSuccessfullyHttpCodeStatus = 201;

  ResponeLogger({
    required this.message,
    required this.httpStatusCode,
  });

  factory ResponeLogger.fromJson(Map<String, dynamic> json) {
    return ResponeLogger(
      message: json['message'] as String,
      httpStatusCode: json['level'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'level': httpStatusCode,
    };
  }
}
