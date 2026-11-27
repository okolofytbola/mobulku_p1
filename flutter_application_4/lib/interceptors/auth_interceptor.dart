import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  String apiKey;

  AuthInterceptor({this.apiKey = 'WxFex5bq8wtHWgVxTjXc2ztZT2sf9baY2NLzgQe'});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (apiKey.isNotEmpty) {
      options.headers['X-Api-Key'] = apiKey;
    }
    super.onRequest(options, handler);
  }
}
