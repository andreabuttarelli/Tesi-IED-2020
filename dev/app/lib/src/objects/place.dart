import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String id;
  String name;
  GeoPoint geoPoint;
  String image;

  Place({this.id, this.name, this.geoPoint, this.image});

  Place.fromJson(Map<String, dynamic> json, String pid) {
    id = pid;
    name = json['name'];
    geoPoint = GeoPoint(
      json["coords"].latitude,
      json["coords"].longitude,
    );
    image = json['image'] ?? null;
    print(json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['coords'] = this.geoPoint;
    data['image'] = this.image;
    return data;
  }
}
