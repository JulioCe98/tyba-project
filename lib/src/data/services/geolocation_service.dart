import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class GeolocationService {
  Future<Map<String, dynamic>?> translateAddressIntoPlaceId(String address, {int limit = 1}) async {
    var url = Uri.https('api.geoapify.com', '/v1/geocode/search',
        {'text': address, 'lang': 'en', 'limit': "$limit", 'type': 'city', 'apiKey': '0f9d238bf3b648829dd0902fb6737f1a'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<Position?> getPosition() async {
    bool status = await checkPermission();
    if (status) {
      return Geolocator.getCurrentPosition();
    }
    return null;
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
      return false;
    }

    return true;
  }
}
