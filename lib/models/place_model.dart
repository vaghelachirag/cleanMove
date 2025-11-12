class Place {
  double? lat;
  double? lng;
  String? placeId;
  String? placeName;

  Place({
    this.lat,
    this.lng,
    this.placeId,
    this.placeName,
  });

  @override
  String toString() {
    return 'Place(lat: $lat, lng: $lng, placeId: $placeId, placeName: $placeName)';
  }
}
