import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1IjoiZWxpemEwODA4IiwiYSI6ImNsbDN2eTNsbzAwZDEzZnQwbG5wMXNodGMifQ.b19vn8jvfiY_Lq-p9iY-eQ';

class TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}