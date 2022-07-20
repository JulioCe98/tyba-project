import 'package:tyba_hiring_test/src/data/models/place.dart';
import 'package:tyba_hiring_test/src/data/services/places_service.dart';

class RemotePlacesRepository {
  final PlacesService _placesService;

  RemotePlacesRepository(this._placesService);

  Future<List<Place>?> getPlacesByAddress(String cityPlaceId, String category) async {
    Map<String, dynamic>? rawData = await _placesService.getPlacesByAddress(cityPlaceId, category);
    if (rawData != null) {
      List<Place> places = [];
      for (var item in rawData['features']) {
        places.add(Place.fromMap(item['properties']));
      }
      return places;
    } else {
      return null;
    }
  }
}
