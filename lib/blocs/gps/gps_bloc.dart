import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;
  GpsBloc(): super(GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionevent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)
        ));
    _init();
  }
  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);
//añadismos elevento el cual enviara el isgpsoermision mandara el stado como este
    add(GpsAndPermissionevent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1]));
  }
Future<bool> _isPermissionGranted() async{
  final isGranted = await Permission.location.isGranted;
  return isGranted;
}
  //esto chequea que el gps este activado o no
  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      //esto verifica si esta el gps este activado, si lo esta manda true
      final isEnable = ((event.index == 1) ? true : false);
      print('service status $isEnable');
      add(GpsAndPermissionevent(
          isGpsEnabled: isEnable,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isEnable;
  }
  //nuevo future que preguntara por el acceso al gps
  Future<void> askGpsAccess() async{
    final status = await Permission.location.request();
   switch(status){
    
    case PermissionStatus.granted:
    add(GpsAndPermissionevent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
    break;
    //como todos los permisos son iguales lo que devolvera entonces elimino el break de todos
    case PermissionStatus.denied:    
    case PermissionStatus.restricted:   
    case PermissionStatus.limited:    
    case PermissionStatus.provisional:    
    case PermissionStatus.permanentlyDenied:
    add(GpsAndPermissionevent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));

    openAppSettings();
   }
  }
//esta funcion escuando se cierra la aplicaion
  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
