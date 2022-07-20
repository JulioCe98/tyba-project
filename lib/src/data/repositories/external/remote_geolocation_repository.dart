import 'package:tyba_hiring_test/src/data/services/geolocation_service.dart';

class RemoteGeolocationRepository {
  final GeolocationService _geolocationService;

  RemoteGeolocationRepository(this._geolocationService);

  Future<String?> translateAddressIntoPlaceId(String address) async {
    Map<String, dynamic>? rawData = await _geolocationService.translateAddressIntoPlaceId(address);
    if (rawData != null) {
      return rawData['features'][0]['properties']['place_id'];
    } else {
      return null;
    }
  }
}
