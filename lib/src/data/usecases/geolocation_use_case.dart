import 'package:tyba_hiring_test/src/data/repositories/external/remote_geolocation_repository.dart';

class GeolocationUseCase {
  final RemoteGeolocationRepository _remoteGeolocationRepository;

  GeolocationUseCase(this._remoteGeolocationRepository);

  Future<String?> translateAddressIntoPlaceId(String address) async {
    return _remoteGeolocationRepository.translateAddressIntoPlaceId(address);
  }
}
