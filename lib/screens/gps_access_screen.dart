import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class GpsAccesScreen extends StatelessWidget {
  const GpsAccesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
          return !state.isGpsEnabled ? _EnableGpsMessage() : _AccessButton();
        },)
        //_AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Es necesario el acceso al gps'),
        MaterialButton(
          child: Text('solicitar acceso', style: TextStyle(color: Colors.white),),
          color: Colors.black,
          shape: StadiumBorder(),
          elevation: 0,
          //esto al mantener presionado el boton no se ve en este caso gris
          splashColor: Colors.transparent,
          onPressed:(){          
         final gpsBloc = BlocProvider.of<GpsBloc>(context);
         gpsBloc.askGpsAccess();
        } )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Debe habilitar el gps',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}