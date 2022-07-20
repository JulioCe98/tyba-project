import 'package:geolocator/geolocator.dart';

import 'package:tyba_hiring_test/src/data/models/place.dart';
import 'package:tyba_hiring_test/src/data/repositories/external/remote_places.repository.dart';
import 'package:tyba_hiring_test/src/data/repositories/local/local_geolocation_repository.dart';

class PlacesUseCase {
  final RemotePlacesRepository _remotePlacesRepository;
  final LocalGeolocationRepository _localGeolocationRepository;

  PlacesUseCase(this._remotePlacesRepository, this._localGeolocationRepository);

  Future<List<Place>?> getPlacesByAddress(String cityPlaceId, String category) async {
    return _remotePlacesRepository.getPlacesByAddress(cityPlaceId, category);
  }

  Future<List<Place>?> getPlacesNearByUser(category) async {
    Position? position = await _localGeolocationRepository.getCurrentUserLocation();
    if (position != null) {
      return _remotePlacesRepository.getPlacesNearByUser(position, category);
    }
    return null;
  }
}
