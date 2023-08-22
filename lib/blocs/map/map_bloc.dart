import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //se esta mandando la referencia para poder usar el location bloc aqui
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;
  StreamSubscription<LocationState>? locationStateSubscription;
  MapBloc({required this.locationBloc}) : super(MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    //emitira el valor si es true mostrara la ruta si no no lo hara
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylinesEvent>((event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)),);
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      //esto trazara la linea(polyline) cuando la ultima ubicacion sea diferente de null
      if (locationState.lastKnownLocation != null) {
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

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.black,
        width: 4,
        points: destination.points,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap);
    //vamos a mostrear los kms entre destinos
    double kms = destination.distance / 100;
    kms = (kms * 100).floorToDouble();
    //esto es lo mismo que km = km / 100
    kms /= 100;
    double tripDuration = (destination.duration / 60).floorToDouble();
    // esta es la creacion de los markers
    final startMarker = Marker(
      markerId: MarkerId('start'), 
      position: destination.points.first,
      //esto es lo que da la informacion del marker selecionado
      infoWindow:  InfoWindow(
        title: 'Inicio',
        snippet: 'kms: $kms, duration: $tripDuration'
      )
      );
    final endMarker = Marker(
      markerId: MarkerId('end'), 
      position: destination.points.last,
      infoWindow: InfoWindow(
        title: destination.endPlace.text,
        snippet: destination.endPlace.placeName
      )
      );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;
    
    add(DisplayPolylinesEvent(currentPolylines, currentMarkers));
  }

  //esto va a servir para servir el mapa a cualquier lugar
  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
