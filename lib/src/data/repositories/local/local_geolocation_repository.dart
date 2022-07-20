import 'package:geolocator/geolocator.dart';

import 'package:tyba_hiring_test/src/data/services/geolocation_service.dart';

class LocalGeolocationRepository {
  final GeolocationService _geolocationService;

  LocalGeolocationRepository(this._geolocationService);

  Future<Position?> getCurrentUserLocation() {
    return _geolocationService.getPosition();
  }
}
