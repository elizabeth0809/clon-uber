part of 'map_bloc.dart';

class MapState extends Equatable {
  //esto es si el mapa esta inicializado
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  //polylines
  final Map<String, Polyline> polylines;

  const MapState({ 
    this.isMapInitialized = false,
    this.isFollowingUser = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines
   }): polylines = polylines ?? const {};
  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyRoute,
    Map<String, Polyline>? polylines
  }) =>MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showMyRoute: showMyRoute ?? this.showMyRoute,
    polylines:  polylines ?? this.polylines
  );
  
  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser, showMyRoute,polylines];
}

class MapInitial extends MapState {}
