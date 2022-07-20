import 'dart:convert';

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
}
