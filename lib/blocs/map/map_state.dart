part of 'map_bloc.dart';

class MapState extends Equatable {
  //esto es si el mapa esta inicializado
  final bool isMapInitialized;
  final bool followUser;
  const MapState({ 
    this.isMapInitialized = false,
    this.followUser = true
   });
  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
  }) =>MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    followUser: followUser ?? this.followUser
  );
  
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}
