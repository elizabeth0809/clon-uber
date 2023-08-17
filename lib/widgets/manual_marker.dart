import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker 
        ? const _ManualMarkerBody() 
        : SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(top: 70, left: 20, child: _BtnBack()),
          Center(
            child: Transform.translate(
                offset: Offset(0, -22),
                child: BounceInDown(
                    child: Icon(
                  Icons.location_on_rounded,
                  size: 60,
                ))),
          ),
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                child: MaterialButton(
                  minWidth: size.width - 120,
                  child: Text('Confirmar destino',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  color: Colors.black,
                  elevation: 0,
                  height: 50,
                  //bordes redondeados
                  shape: StadiumBorder(),
                  onPressed: () async{
                    final start = locationBloc.state.lastKnownLocation;
                    if(start == null) return;
                    final end = mapBloc.mapCenter;
                    if(end == null) return;
                  final destination = await searchBloc.getCoorsStartToEnd(start, end);
                   mapBloc.drawRoutePolyline(destination);
                  },
                ),
              ))
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              BlocProvider.of<SearchBloc>(context).add(OnDeactivateManualMarkerEvent());
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
    );
  }
}
