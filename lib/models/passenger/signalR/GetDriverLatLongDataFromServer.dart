class GetDriverLatLongDatFromServer {
    int? dailyRouteTrackingId;
    int? dailyRouteId;
    int? routeId;
    String? routeTrackData;

    GetDriverLatLongDatFromServer({
        this.dailyRouteTrackingId,
        this.dailyRouteId,
        this.routeId,
        this.routeTrackData,
    });

    factory GetDriverLatLongDatFromServer.fromJson(Map<String, dynamic> json) => GetDriverLatLongDatFromServer(
        dailyRouteTrackingId: json["dailyRouteTrackingId"],
        dailyRouteId: json["dailyRouteId"],
        routeId: json["routeId"],
        routeTrackData: json["routeTrackData"],
    );

    Map<String, dynamic> toJson() => {
        "dailyRouteTrackingId": dailyRouteTrackingId,
        "dailyRouteId": dailyRouteId,
        "routeId": routeId,
        "routeTrackData": routeTrackData,
    };
}
