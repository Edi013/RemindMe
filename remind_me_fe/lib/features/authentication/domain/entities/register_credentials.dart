class RegisterCredentials {
  String nickname;
  String email;
  String password;

  RegisterCredentials({
    required this.email,
    required this.nickname,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'password': password,
    };
  }
}
