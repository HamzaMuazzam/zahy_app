import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:musan_client/utils/colors.dart';



class GMapsTrackWorkshop extends StatefulWidget {
  double longitude, latitude;
  GMapsTrackWorkshop(this.longitude,this.latitude, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GMapsTrackWorkshopState createState() => _GMapsTrackWorkshopState();
}

class _GMapsTrackWorkshopState extends State<GMapsTrackWorkshop> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  double lat,lng;
  static final CameraPosition initialLocation = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);

  Future<Uint8List> getMarker() async {
    ByteData byteData =await DefaultAssetBundle.of(context).load("assets/images/gps.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("Location"),
          position: latlng,
          rotation: 0,
          draggable: true,

          flat: true,
          icon: BitmapDescriptor.fromBytes(imageData));

    });
  }

  void updateMarkerAndCircleWorkShopTracking(Uint8List imageData) {
    LatLng latlng = LatLng(widget.latitude,widget.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("Location"),
          position: latlng,
          rotation: 0,
          draggable: true,

          flat: true,
          icon: BitmapDescriptor.fromBytes(imageData));

    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
            if (_controller != null) {

              lat=newLocalData.latitude;
              lng=newLocalData.longitude;

              _controller.animateCamera(CameraUpdate.newCameraPosition(
                  new CameraPosition(
                      bearing: 0,
                      target: LatLng(newLocalData.latitude, newLocalData.longitude),
                      tilt: 0,
                      zoom: 18.00)));


              updateMarkerAndCircle(newLocalData, imageData);
            }
          });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, []);
          },
        ),
        backgroundColor: themeColor,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            markers: Set.of((marker != null) ? [marker] : []),
            // circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;

              _controller.animateCamera(CameraUpdate.newCameraPosition(
                  new CameraPosition(
                      bearing: 0,
                      target: LatLng(widget.latitude, widget.longitude),
                      tilt: 0,
                      zoom: 18.00)));

              getMarker().then((imageData){
                updateMarkerAndCircleWorkShopTracking(imageData);

              });



            },
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(1,0.75),
        child: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: Icon(Icons.location_searching),
            onPressed: () {
              getCurrentLocation();
            }),
      ),
    );
  }

}
