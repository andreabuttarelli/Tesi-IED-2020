import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String id;
  String name;
  GeoPoint geoPoint;

  Place({this.id, this.name, this.geoPoint});

  Place.fromJson(Map<String, dynamic> json) {
    print(json['coords']);
    id = json['id'];
    name = json['name'];
    geoPoint = GeoPoint(
      json["coords"].latitude,
      json["coords"].longitude,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['coords'] = this.geoPoint;
    return data;
  }

  GeoPoint parseGeoPoint(Map<String, dynamic> json) {
    print(json);
  }
}
