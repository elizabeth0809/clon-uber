part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
  
}
class OnMapInitializedEvent extends MapEvent {
    final GoogleMapController controller;
    OnMapInitializedEvent(this.controller);
   }
class OnStopFollowingUserEvent extends MapEvent {}
class OnStartFollowingUserEvent extends MapEvent {}