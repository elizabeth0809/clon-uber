import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class SearBar extends StatelessWidget {
  const SearBar({super.key});
//esto hace que al precionar el boton manual desaparezca la barra de busqueda
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
        ? SizedBox()
        : FadeInDown(child: _SearBarBody());
      },
    );
        
  }
}

class _SearBarBody extends StatelessWidget {
  const _SearBarBody({super.key});
  void onSearchResult(BuildContext context, SearchResult result) async{
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapbloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }
    //revidar si tenemos la posicion de la direccion
    if(result.position !=null && locationBloc.state.lastKnownLocation != null){
      final destination = await searchBloc.getCoorsStartToEnd(locationBloc.state.lastKnownLocation!, result.position!);
      await mapbloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());
            if (result == null) return;
            onSearchResult(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Text('¿Donde quieres ir?',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }
}
