import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';

import 'package:maps_app/widgets/widgets.dart';

class MapScrenn extends StatefulWidget {
  const MapScrenn({super.key});

  @override
  State<MapScrenn> createState() => _MapScrennState();
}

class _MapScrennState extends State<MapScrenn> {
  late LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);

  //solose dispara cuando elwidget se construye
  @override
  void initState() {
    super.initState();
    //locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    //esto limpia la subscripcion
    super.dispose();
    locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null){ 
            return Center(child: Text('Espere por favor...'));
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from( mapState.polylines );
              if ( !mapState.showMyRoute ) {
                //LO QUE DETERMINA SI aparece o no la polilyne es el key
                polylines.removeWhere((key, value) => key == 'myroute');
              }
    
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(), 
                      markers: mapState.markers.values.toSet(),
                    ),
                  SearBar(),
                  ManualMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BtnToggleUserRoute(),
            BtnCurrentLocation(), BtnFollowUser()]),
    );
  }
}
