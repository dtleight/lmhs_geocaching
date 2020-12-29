import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmhsgeocaching/Objects/Cache.dart';
import 'package:location/location.dart';

class CacheMap extends StatefulWidget
{
  Cache cache;
  CacheMap(Cache cache){this.cache = cache;}

  @override
  State<StatefulWidget> createState()
  {
    return CacheMapState(cache);
  }
}

class CacheMapState extends State<CacheMap>
{ GoogleMapController mapController;
LatLng _pos = const LatLng(40.523938, -75.547719);
LocationData currentLocation;
Location location;
Cache cache;

  CacheMapState(Cache cache){this.cache = cache;}

  @override
  Widget build(BuildContext context)
  {
    return GoogleMap
      (
      onMapCreated: _onMapCreated,
      mapType: MapType.satellite,
      markers: [Marker(markerId: MarkerId("Cache Location"),position: LatLng(cache.location.latitude,cache.location.longitude))].toSet(),
      initialCameraPosition: CameraPosition(
        target: _pos,
        zoom: 17.0,
      ),
      myLocationEnabled: true,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void _getLocation() async {
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      setState(() {});
    } on Exception {
      currentLocation = null;
    }
  }
}