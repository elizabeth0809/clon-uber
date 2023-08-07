import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

import '../ui/ui.dart';
//este boton al precionarlo siempre nos llevara al centro
class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    //mi ubicacion esta en mapbloc
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.red,
        maxRadius: 25,
        child: IconButton(
          onPressed: (){
          final userLocation = locationBloc.state.lastKnownLocation;
          //si la locacion es nula entonces va lanzar este snackbar
          if(userLocation == null ) {
            final snack = CustomSnackBar(message: 'no hay ubicacion');
          ScaffoldMessenger.of(context).showSnackBar(snack);
            return;
            }
//al presionar volvera a mi ubicacion señalada
          mapBloc.moveCamera(userLocation);
        }, icon: Icon(Icons.my_location)),
      ),
    );
  }
}