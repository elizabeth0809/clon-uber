import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  // el super es elñ constructor del seacrhdelegate por lo cual en este caso cambiamos el buscar
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');
  @override
  List<Widget>? buildActions(BuildContext context) {
    //esto retorna una lista de widgets
    return [
      //esto elimina lo que se este escribiendo
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //esto hace que se pueda dar marcha atras en el buscador
    return IconButton(
        onPressed: () {
          final result = SearchResult(cancel: true);
          close(context, result);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery(proximity, query);


    return BlocBuilder<SearchBloc, SearchState>
    (builder: (context, state){
      final places = state.places;
      return ListView.separated(
        itemBuilder: (context, i){
          final place = places[i];
          return ListTile(
            title: Text(place.text),
            subtitle: Text(place.placeName),
            leading: const Icon(Icons.place_outlined, color: Colors.black,),
            onTap: () {
              final result = SearchResult(
                cancel: false, 
                manual: false,
                position: LatLng(place.center[1], place.center[0]),
                name: place.text,
                description: place.placeName
                );
                //aqui se dispara el evento de historial
                searchBloc.add(AddToHistoryEvent(place));
            close(context, result);
            },
          );
        }, 
        separatorBuilder: (context, i) => const Divider(), 
        itemCount: places.length);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: Text(
            'colocar la ubicacion manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        //aqui se muestra el historial
        ...history.map((place) => ListTile(
          title: Text(place.text),
          subtitle: Text(place.placeName),
          leading: const Icon(Icons.history, color: Colors.black),
          //al presionar este elemto del historial muestra el polilyne de ese elemento
          onTap: () {
            final result = SearchResult(
                cancel: false, 
                manual: false,
                position: LatLng(place.center[1], place.center[0]),
                name: place.text,
                description: place.placeName
                );
               
            close(context, result);
          },
          ))
      ],
    );
  }
}
