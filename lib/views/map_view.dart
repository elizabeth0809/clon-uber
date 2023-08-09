import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView({
    super.key, 
    required this.initialLocation, 
    required this.polylines});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
          target: initialLocation,
          zoom: 15
        );
        final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        //esto va a saber cuando la camara se mueve
        onPointerMove: (PointerMoveEvent) => mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: true,
          //esto es para mostrar mi ubicacion en eel mapa
          myLocationEnabled: true,
          //esto es los botones de mas o menos del zoom
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          //esto es lo que muestra las polyline
          polylines: polylines,
          onMapCreated: (controller) => mapBloc.add(OnMapInitializedEvent(controller)),
          ),
      ));
  }
}