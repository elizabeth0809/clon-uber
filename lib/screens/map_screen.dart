import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';

class MapScrenn extends StatefulWidget {
  const MapScrenn({super.key});

  @override
  State<MapScrenn> createState() => _MapScrennState();
}

class _MapScrennState extends State<MapScrenn> {
  late LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
 
  //solose dispara cuando elwidget se construye
  @override
void initState(){
  super.initState();
  //locationBloc = BlocProvider.of<LocationBloc>(context);
  //locationBloc.getCurrentPosition();
  locationBloc.startFollowingUser();
  
}
@override
void dispose(){
  //esto limpia la subscripcion
  super.dispose();
  locationBloc.stopFollowingUser();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if(state.lastKnownLocation == null) return Center(child: Text('Espere por favor...'));
        
        return SingleChildScrollView(
          child: Stack( children: [
            MapView(initialLocation: state.lastKnownLocation!,)
          ],),
        );
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(children: [Text('hola mundo')]),
    );
  }
}