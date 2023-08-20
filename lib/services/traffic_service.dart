import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

class TrafficService{
  final Dio _dioTraffic;
  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
//asi se crea la instacia
  TrafficService() 
  : _dioTraffic = Dio()..interceptors.add( TrafficInterceptor() );

  Future<TrafficResponse> getCoorsStartToEnd (LatLng start, LatLng end) async{
    final coorsString = '${start.longitude}, ${start.latitude}; ${end.longitude}, ${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';

    final resp = await _dioTraffic.get(url);
    final data = TrafficResponse.fromMap(resp.data);
    
    return data;
  }
  Future getResultByQuery (LatLng proximity, String query) async{
    if(query.isEmpty) return [];
    final url = '$_basePlacesUrl/$query.json';
    return [];
  }
}