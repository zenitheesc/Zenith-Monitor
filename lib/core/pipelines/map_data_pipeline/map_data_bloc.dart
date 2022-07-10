import 'package:bloc/bloc.dart';

part 'map_data_state.dart';
part 'map_data_event.dart';

class MapDataBloc extends Bloc<MapDataEvent, MapDataState> {
  MapDataBloc() : super(MapDataStateInitial());
}
