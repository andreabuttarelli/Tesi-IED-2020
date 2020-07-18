import 'package:app/src/blocs/token/index.dart';
import 'package:app/src/objects/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class TokenRepository {
  Future<List<Place>> getAllTokens() async {
    List<Place> places = [];
    await Firestore.instance.collection('locations').getDocuments().then(
          (data) => data.documents.forEach(
            (doc) {
              var place = Place.fromJson(doc.data);
              places.add(place);
            },
          ),
        ); //TODO:
    //.where('token', isEqualTo: true)
    return places;
  }

  Future<TokenState> findNearest(
      {GeoPoint myPosition, List<Place> places}) async {
    final Distance distance = new Distance();
    double minDistance = -1;
    int index;

    for (int i = 0; i < places.length; i++) {
      final double dist = distance(
        new LatLng(myPosition.latitude, myPosition.longitude),
        new LatLng(places[i].geoPoint.latitude, places[i].geoPoint.longitude),
      );
      if (minDistance == -1) {
        minDistance = dist;
        index = i;
      } else if (dist < minDistance) {
        minDistance = dist;
        index = i;
      }
    }

    if (minDistance < 1000)
      return PlaceFound(place: places[index]);
    else
      return Null();
  }
}
