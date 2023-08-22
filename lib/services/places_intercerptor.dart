import 'package:dio/dio.dart';
class PlacesInterceptor extends Interceptor{
final accessToken = 'pk.eyJ1IjoiZWxpemEwODA4IiwiYSI6ImNsbDN2eTNsbzAwZDEzZnQwbG5wMXNodGMifQ.b19vn8jvfiY_Lq-p9iY-eQ';
  
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      
      'access_token': accessToken,
      'language' : 'es',
      
    });
    super.onRequest(options,handler);
  }
}