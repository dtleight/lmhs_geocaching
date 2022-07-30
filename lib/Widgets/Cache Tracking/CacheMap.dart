import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';

class CacheMap extends StatefulWidget {
  final Cache cache;

  CacheMap(this.cache);

  @override
  State<StatefulWidget> createState() => CacheMapState();
}

class CacheMapState extends State<CacheMap> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getLocation(),
      builder: (context, AsyncSnapshot<LatLng> snapshot) {
        LatLng cacheLoc = LatLng(
          widget.cache.location.latitude,
          widget.cache.location.longitude,
        );

        return snapshot.hasData
            ? GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.satellite,
                markers: [
                  Marker(
                    markerId: MarkerId("Cache Location"),
                    position: cacheLoc,
                  )
                ].toSet(),
                initialCameraPosition: CameraPosition(
                  // snapshot.data != null because snapshot.hasData == true
                  target: snapshot.data!,
                  zoom: 17.0,
                ),
                myLocationEnabled: true,
                circles: Set.from([
                  Circle(
                    circleId: CircleId("Cache Circle"),
                    center: cacheLoc,
                    radius: 30.48,
                    // 100 ft in meters
                    fillColor: Colors.green.withOpacity(.3),
                    strokeWidth: 1,
                    strokeColor: Colors.green,
                  ),
                ]))
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future<LatLng> _getLocation() async {
    Position currPos = await Geolocator.getCurrentPosition();
    return LatLng(currPos.latitude, currPos.longitude);
  }
}
