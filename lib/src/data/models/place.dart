import 'dart:convert';

class Place {
  Place(
      {required this.name,
      required this.housenumber,
      required this.street,
      required this.neighbourhood,
      required this.suburb,
      required this.postcode,
      required this.lon,
      required this.lat,
      required this.formatted,
      required this.addressLine1,
      required this.addressLine2,
      required this.categories,
      required this.placeId,
      required this.image,
      required this.phoneNumber,
      required this.sector});

  String name;
  String housenumber;
  String street;
  String neighbourhood;
  String suburb;
  String postcode;
  double lon;
  double lat;
  String formatted;
  String addressLine1;
  String addressLine2;
  List<String> categories;
  String placeId;
  String image;
  String phoneNumber;
  String sector;

  factory Place.fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        name: json["name"] ?? 'Sin nombre',
        housenumber: json["housenumber"] ?? '',
        street: json["street"],
        neighbourhood: json["neighbourhood"],
        suburb: json["suburb"],
        postcode: json["postcode"],
        lon: json["lon"].toDouble(),
        lat: json["lat"].toDouble(),
        formatted: json["formatted"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        placeId: json["place_id"],
        image: json["datasource"]['raw']['image'] ?? '',
        phoneNumber: json["datasource"]['raw']['phone']?.toString() ?? 'NA',
        sector: json["county"] ?? 'NA',
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "housenumber": housenumber,
        "street": street,
        "neighbourhood": neighbourhood,
        "suburb": suburb,
        "postcode": postcode,
        "lon": lon,
        "lat": lat,
        "formatted": formatted,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "place_id": placeId,
        "image": image,
        "phone": phoneNumber,
        "county": sector
      };
}
