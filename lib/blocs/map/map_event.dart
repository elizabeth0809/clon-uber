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
class UpdateUserPolylineEvent extends MapEvent{
  final List<LatLng> userLocations;
  UpdateUserPolylineEvent(this.userLocations);
}
class OnToggleUserRoute extends MapEvent{}
//evento de polilynes
class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  const DisplayPolylinesEvent(this.polylines);
}