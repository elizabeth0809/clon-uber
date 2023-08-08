part of 'location_bloc.dart';

class LocationState extends Equatable {
  //se necesita saber si se esta siguiendo alusuario
  final bool followingUser;
  final LatLng? lastKnownLocation;
  //esto guarda todas las longitudes y latitudes por lass cuales me e movido
  final List<LatLng> myLocationHistory;
  //ultima ubicacion

  //historia
  const LocationState({
    this.followingUser = false,
    this.lastKnownLocation, 
    myLocationHistory
    //aqui sino viene valor se inicia vacio
  }) : myLocationHistory = myLocationHistory ?? const [];
  LocationState copyWith({
     bool? followingUser,
   LatLng? lastKnownLocation,
   List<LatLng>? myLocationHistory,
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory
  );
  @override
  //aqui se comparan todos los objetos
  List<Object?> get props => [followingUser, lastKnownLocation, myLocationHistory];
}

