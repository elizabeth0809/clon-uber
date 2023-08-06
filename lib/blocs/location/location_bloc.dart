import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;


part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  
  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>((event, emit) =>(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>((event, emit) => emit(state.copyWith(followingUser: false)),);
    on<OnNewUserLocationEvent>((event, emit) {
     emit(state.copyWith(
      lastKnownLocation: event.newLocation,
      //para dispersar y despues guardarlo en event.newlocation se usan los ...
      myLocationHistory: [...state.myLocationHistory, event.newLocation],
     ));
    });
  }
  Future<void> getCurrentPosition() async {
  try {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  } catch (e) {
    if (e is LocationServiceDisabledException) {
      // Manejar la excepción de servicio de ubicación desactivado aquí
      print('El servicio de ubicación está desactivado.');
    } else {
      // Otras excepciones de geolocalización pueden ser manejadas aquí
      print('Error al obtener la posición: $e');
    }
  }
}

  void startFollowingUser(){
    print('startFollingUser');
    add(OnStartFollowingUser());
    //esto se mantendra escuchando lalongitud y latitud del dispositivo
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position =event;
      //aqui se dispara el eventoporque se sabe ya la posicion
     add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    });
  }
  void stopFollowingUser(){
    
    positionStream?.cancel();
    add(OnStopFollowingUser());
    print('stopFollwingUser');
  }
  Future<void> close(){
    positionStream?.cancel();
    //aqui se limpiara la subcripcion
    return super.close();
  }
}
