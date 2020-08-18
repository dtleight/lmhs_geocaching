import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Objects/Cache.dart';
import '../Singletons/DatabaseRouting.dart';

class CacheNearbyPage extends StatefulWidget
{
  CacheNearbyPage({Key key, this.cache}) : super(key: key);

  final Cache cache;

  @override
  _NearbyMapState createState() => _NearbyMapState();
}

class _NearbyMapState extends State<CacheNearbyPage> {
  GoogleMapController mapController;
  LatLng _cacheLoc;
  LocationData currentLocation;
  Location location;
  Set<Marker> markers;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context)
  {
    _cacheLoc = LatLng(widget.cache.location.latitude, widget.cache.location.longitude);
    return Scaffold(
      body: FutureBuilder
        (
        future:  new DatabaseRouting().loadCaches(),
        builder: (context,snapshot)
        {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');

            default:
              return GoogleMap
                (
                onMapCreated: _onMapCreated,
                mapType: MapType.satellite,
                initialCameraPosition: CameraPosition
                  (
                  target: _cacheLoc,
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
                    center: _cacheLoc,
                    radius: 30.48, /*100 ft in meters*/
                    fillColor: Colors.green.withOpacity(.3),
                    strokeWidth: 1,
                    strokeColor: Colors.green
                  )]
                ),
              );
          }
        },
      ),
    );
  }
}