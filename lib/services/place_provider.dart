import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';

import '../models/place_model.dart';
import '../models/suggestion_model.dart';

class PlaceApiProvider extends GetConnect {

  final apiKey = AppConstant.MapApiKey;
  final sessionToken = "121";

  final PolylinePoints _polylinePoints = PolylinePoints();

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    var response = await get(request);
    if (response.statusCode == 200) {
      if (response.body != null) {
        final result = json.decode(json.encode(response.body));
        if (result['status'] == 'OK') {
          return result['predictions']
              .map<Suggestion>((p) {
                return Suggestion(p['place_id'], p['description']);
              }).toList();
        }
        if (result['status'] == 'ZERO_RESULTS') {
          return [];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId, String placeName) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await get(request);
    if (response.statusCode == 200) {
      final result = json.decode(json.encode(response.body));
      if (result['status'] == 'OK') {
        final geometry = result['result']['geometry'];
        // build result
        final place = Place();
        place.lat = geometry['location']['lat'];
        place.lng = geometry['location']['lng'];
        place.placeId = placeId;
        place.placeName = placeName;
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<PolylineResult> getCreatedPolyline(PointLatLng startPoint, PointLatLng endPoint, List<PolylineWayPoint> wayPoints) async {
    try {
      return await _polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        startPoint,
        endPoint,
        travelMode: TravelMode.driving,
        wayPoints: wayPoints,
      );
    } catch (e) {
      print("Data"+ "Fail"+ e.toString());
      return PolylineResult(status: "Fail");
    }
  }
}