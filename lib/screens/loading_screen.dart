import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';
import 'package:maps_app/screens/gps_access_screen.dart';
import 'package:maps_app/screens/map_screen.dart';

class Loadingscreen extends StatelessWidget {
  const Loadingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
        return state.isAllGranted ?
        MapScrenn() : GpsAccesScreen();
      },),
    );
  }
}