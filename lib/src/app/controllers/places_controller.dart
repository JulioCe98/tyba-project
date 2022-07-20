import 'package:riverpod/riverpod.dart';

import 'package:tyba_hiring_test/src/data/models/place.dart';
import 'package:tyba_hiring_test/src/data/providers/providers.dart';
import 'package:tyba_hiring_test/src/data/usecases/places_use_case.dart';

class PlacesState {
  final List<Place> loadedPlaces;

  PlacesState({required this.loadedPlaces});

  PlacesState copyWith({List<Place>? places}) {
    return PlacesState(loadedPlaces: places ?? loadedPlaces);
  }
}

class PlacesController extends StateNotifier<PlacesState> {
  final Ref ref;
  final PlacesUseCase _placesUseCase;

  PlacesController(this.ref, this._placesUseCase) : super(PlacesState(loadedPlaces: []));

  void getPlacesByAddress(String address, String category) async {
    String? addressPlaceId = await ref.read(geolocationUseCaseProvider).translateAddressIntoPlaceId(address);
    if (addressPlaceId != null) {
      List<Place>? places = await _placesUseCase.getPlacesByAddress(addressPlaceId, category);
      state = state.copyWith(places: places);
    }
  }
}
