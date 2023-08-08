part of 'map_bloc.dart';

class MapState extends Equatable {
  //esto es si el mapa esta inicializado
  final bool isMapInitialized;
  final bool isFollowingUser;
  const MapState({ 
    this.isMapInitialized = false,
    this.isFollowingUser = true
   });
  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) =>MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser
  );
  
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}
