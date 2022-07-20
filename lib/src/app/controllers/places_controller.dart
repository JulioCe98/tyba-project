import 'package:riverpod/riverpod.dart';

import 'package:tyba_hiring_test/src/data/models/place.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';
import 'package:tyba_hiring_test/src/data/usecases/places_use_case.dart';

class PlacesState {
  final bool isFetching;
  final List<Place> loadedPlaces;

  PlacesState({required this.loadedPlaces, required this.isFetching});

  PlacesState copyWith({List<Place>? places, bool? fetching}) {
    return PlacesState(loadedPlaces: places ?? loadedPlaces, isFetching: fetching ?? isFetching);
  }

  PlacesState clean() {
    return PlacesState(loadedPlaces: [], isFetching: false);
  }
}

class PlacesController extends StateNotifier<PlacesState> {
  final Ref ref;
  final PlacesUseCase _placesUseCase;

  PlacesController(this.ref, this._placesUseCase) : super(PlacesState(loadedPlaces: [], isFetching: false));

  void getPlacesByAddress(String address, String category) async {
    state = state.copyWith(fetching: true);
    String? addressPlaceId = await ref.read(geolocationUseCaseProvider).translateAddressIntoPlaceId(address);
    if (addressPlaceId != null) {
      List<Place>? places = await _placesUseCase.getPlacesByAddress(addressPlaceId, category);
      state = state.copyWith(places: places, fetching: false);
    }
  }

  void getPlacesNearByUser(String category) async {
    state = state.copyWith(fetching: true);
    List<Place>? places = await _placesUseCase.getPlacesNearByUser(category);
    state = state.copyWith(places: places, fetching: false);
  }

  void cleanState() {
    state = state.clean();
  }
}
