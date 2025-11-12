import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class SetPickupWayPointsModel{
  LatLng ? location;
  int ? pickupOrder;
  int ? id;


  SetPickupWayPointsModel({
    this.location,
    this.pickupOrder,
    this.id,
  });

}
