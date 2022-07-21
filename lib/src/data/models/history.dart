import 'dart:convert';

class History {
  String searchCriteria;

  String dateTime;

  History({required this.searchCriteria, required this.dateTime});

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(searchCriteria: json["searchCriteria"], dateTime: json["dateTime"]);

  Map<String, dynamic> toMap() => {"searchCriteria": searchCriteria, "dateTime": dateTime};
}
