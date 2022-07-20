import 'package:tyba_hiring_test/src/data/models/place.dart';

import 'package:tyba_hiring_test/src/data/repositories/external/remote_places.repository.dart';

class PlacesUseCase {
  final RemotePlacesRepository _remotePlacesRepository;

  PlacesUseCase(this._remotePlacesRepository);

  Future<List<Place>?> getPlacesByAddress(String cityPlaceId, String category) async {
    return _remotePlacesRepository.getPlacesByAddress(cityPlaceId, category);
  }
}
