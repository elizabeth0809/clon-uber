import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //se esta mandando la referencia para poder usar el location bloc aqui
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  MapBloc({ 
    required this.locationBloc
  }) : super(MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    locationBloc.stream.listen((locationState) {
      if(!state.followUser) return;
      if(locationState.lastKnownLocation == null) return;
//cuando el usuario se mueva la camara va a seguirlo
      moveCamera(locationState.lastKnownLocation!);
    });
  }
  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
   }
   //esto va a servir para servir el mapa a cualquier lugar
  void moveCamera(LatLng newLocation){
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController!.animateCamera(cameraUpdate);
  }
}
