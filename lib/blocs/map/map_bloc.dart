import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //se esta mandando la referencia para poder usar el location bloc aqui
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  MapBloc({required this.locationBloc}) : super(MapState()) {


    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);


    locationBloc.stream.listen((locationState) {
      //esto trazara la linea(polyline) cuando la ultima ubicacion sea diferente de null
      if(locationState.lastKnownLocation != null){
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;
//cuando el usuario se mueva la camara va a seguirlo
      moveCamera(locationState.lastKnownLocation!);
    });
  }
  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  //con esta funcion me mueve directamente a mi ultima ubicacion
  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: PolylineId('myroute'),
        color: Colors.black,
        width: 5,
        //los caps son los bordes redondeados
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myroute'] = myRoute;
    emit(state.copyWith(polylines: currentPolylines));
  }

  //esto va a servir para servir el mapa a cualquier lugar
  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
}
