import 'package:flutter/material.dart';
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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
        )
      ],
    );
  }
}
