import 'package:app/src/blocs/position/index.dart';
import 'package:app/src/objects/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

class PositionRepository {
  List<Place> savedPlaces = [];

  Future<List<Place>> getAllPlaces() async {
    if (savedPlaces.isEmpty) {
      List<Place> places = [];
      await Firestore.instance.collection('locations').getDocuments().then(
            (data) => data.documents.forEach(
              (doc) {
                var place = Place.fromJson(doc.data, doc.documentID);
                places.add(place);
              },
            ),
          );
      savedPlaces = places;
      return places;
    } else {
      return savedPlaces;
    }
  }

  Future<PositionState> findNearest(
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

  Future<List<Place>> getPlacesByName(String query) async {
    if (savedPlaces.isEmpty) {
      getAllPlaces();
    }
    final queryLowerCase = '$query'.toLowerCase();
    final List<Place> searchedPlaces = [];
    for (var i = 0; i < savedPlaces.length - 1; i++) {
      if (savedPlaces[i].name.toLowerCase().contains("$queryLowerCase")) {
        searchedPlaces.add(savedPlaces[i]);
      }
    }
    return searchedPlaces;
  }
}
