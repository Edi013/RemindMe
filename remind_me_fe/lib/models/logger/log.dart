class Log {
  String message;
  int level;
  String exception;

  Log({
    required this.message,
    required this.level,
    required this.exception,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      message: json['message'] as String,
      level: json['level'] as int,
      exception: json['exception'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'level': level,
      'exception': exception,
    };
  }
}
