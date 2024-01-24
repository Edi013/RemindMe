import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor{
  Future<void> onRequest
  (RequestOptions options, RequestInterceptorHandler handler) async{
      final token = await '121';
      if(token != null &&  token.isNotEmpty){
        options.headers['Authorization'] = 'Bearer $token';
      }
      options.headers['Content-Type'] = 'application/json';
      super.onRequest(options, handler);
  }
}