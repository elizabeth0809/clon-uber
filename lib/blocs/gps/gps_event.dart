part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}
//evento que manejara el permiso del gps 
class GpsAndPermissionevent extends GpsEvent{
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  GpsAndPermissionevent({required this.isGpsEnabled,required this.isGpsPermissionGranted});
}