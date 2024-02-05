import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:remind_me_fe/core/constants.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/base_response.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_credentials.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/login_result.dart';
import 'package:remind_me_fe/features/authentication/domain/entities/register_credentials.dart';

class AuthServiceApi {
  final String apiExtension = '/Authentication';
  late String apiUrl;

  AuthServiceApi() {
    apiUrl = "$BASE_URL_AUTHENTICATION_SERVICE$apiExtension";
  }

  Future<String> test() async {
    var result = await http.get(
      Uri.parse('$apiUrl/Test'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*'
      },
    ).then(
      (response) {
        final String data = json.decode(response.body);
        return data;
      },
    );
    return result;
  }

  Future<LoginResponse> login(LoginCredentials credentials) async {
    var httpResult = await http.post(
      Uri.parse('$apiUrl/Login'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json'
      },
      body: jsonEncode(credentials.toJson()),
    );
    //String token = getJwtFromResponse(httpResult);
    String token = "";
    var cookieJar = CookieJar();
    List<Cookie> cookies = [Cookie('jwt', 'test_string')];
    cookieJar.saveFromResponse(Uri.parse('$apiUrl/Login'), cookies);

    var result = LoginResponse.fromJson(json.decode(httpResult.body), token);
    return result;
  }

  String getJwtFromResponse(http.Response httpResult) {
    String? setCookieHeaders = httpResult.headers['set-cookie'];
    if (setCookieHeaders == null) {
      return "";
    }
    var cookies = Cookie.fromSetCookieValue(setCookieHeaders!);
    return cookies.value;
  }

  Future<BaseResult> register(RegisterCredentials credentials) async {
    try {
      return await http
          .post(
            Uri.parse('$apiUrl/Register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(credentials.toJson()),
          )
          .then(
            (value) => BaseResult.fromJson(json.decode(value.body)),
          );
    } catch (err) {
      rethrow;
    }
  }
}
