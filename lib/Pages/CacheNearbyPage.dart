import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Objects/Cache.dart';
import '../Singletons/DatabaseRouting.dart';

class CacheNearbyPage extends StatefulWidget {

  final Cache cache;
  final LatLng cacheLoc;

  CacheNearbyPage(this.cache) : cacheLoc =  LatLng(
    cache.location.latitude,
    cache.location.longitude,
  );

  @override
  NearbyMapState createState() => NearbyMapState();
}

class NearbyMapState extends State<CacheNearbyPage> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: new DatabaseRouting().loadCaches(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');

            default:
              return GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.satellite,
                initialCameraPosition: CameraPosition(
                  target: widget.cacheLoc,
                  zoom: 19.0,
                ),
                myLocationEnabled: true,
                scrollGesturesEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                circles: Set.from([
                  Circle(
                      circleId: CircleId("Cache Circle"),
                      center: widget.cacheLoc,
                      radius: 30.48,
                      /*100 ft in meters*/
                      fillColor: Colors.green.withOpacity(.3),
                      strokeWidth: 1,
                      strokeColor: Colors.green)
                ]),
              );
          }
        },
      ),
    );
  }
}
