import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    //esto junto con lo realizado en search bar hacen que se visualize el marcador de posicion
    on<OnActivateManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarkerEvent>((event, emit) => emit(state.copyWith(displayManualMarker: false)));
    
  }
}
