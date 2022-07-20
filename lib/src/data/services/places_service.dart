import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  Future<Map<String, dynamic>?> getPlacesByAddress(String cityPlaceId, String category, {int limit = 10}) async {
    Uri url = Uri.https('api.geoapify.com', '/v2/places',
        {'categories': category, 'filter': 'place:$cityPlaceId', 'limit': "$limit", 'apiKey': '43c953cfb1e348499ee8bf5a295b370b'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getPlacesNearByUser(Position position, String category, {int limit = 10, int radius = 1000}) async {
    Uri url = Uri.https('api.geoapify.com', '/v2/places', {
      'categories': category,
      'filter': 'circle:${position.longitude},${position.latitude},$radius',
      'limit': "$limit",
      'apiKey': '43c953cfb1e348499ee8bf5a295b370b'
    });

    print(url);
    print(url.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
