part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  //cuando halla cambio de estado devolvera true si ambos son true
bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;
  GpsState({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted});
    //esto copia todo el estado
  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted
  );
  
  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];
  @override
  String toSting() => '{isGpsEnable: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}';
}


