import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:provider/provider.dart';



class GMaps extends StatefulWidget {
  final String title;
  bool showItems;
  GMaps({Key key, this.title,this.showItems=true}) : super(key: key);

  @override
  _GMapsState createState() => _GMapsState();
}

class _GMapsState extends State<GMaps> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  double lat,lng;

  static final CameraPosition initialLocation = CameraPosition(target: LatLng(0, 0), zoom: 14.4746);

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
          // anchor: Offset(0.5, 0.5),
          // zIndex: 2,
          flat: true,
          icon: BitmapDescriptor.fromBytes(imageData));
          //     circle = Circle(
          //     circleId: CircleId("car"),
          //     radius: newLocalData.accuracy,
          //     zIndex: 1,
          //     strokeColor: Colors.blue,
          //     center: latlng,
          //     fillColor: Colors.blue.withAlpha(70));
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
      print("LOCATION");
      final position = await _geolocatorPlatform.getCurrentPosition();

      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 0,
              target: LatLng(position.latitude, position.longitude),
              tilt: 0,
              zoom: 18.00)));

      // _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
      //   if (_controller != null) {
      //
      //     lat=newLocalData.latitude;
      //     lng=newLocalData.longitude;
      //
      //     _controller.animateCamera(CameraUpdate.newCameraPosition(
      //         new CameraPosition(
      //             bearing: 0,
      //             target: LatLng(newLocalData.latitude, newLocalData.longitude),
      //             tilt: 0,
      //             zoom: 18.00)));
      //
      //
      //     // updateMarkerAndCircle(newLocalData, imageData);
      //   }
      // });
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
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  CameraPosition newCameraMoveTo;
  MapType maptype= MapType.normal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showItems ? AppBar(
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
      ) : null ,
      body: Stack(
        children: [
          GoogleMap(
            mapType: maptype,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,

            initialCameraPosition: initialLocation,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            markers: Set.of((marker != null) ? [marker] : []),
            // circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
              final position = await _geolocatorPlatform.getCurrentPosition();
              print("Current Location: $position");
              // _controller.moveCamera(CameraUpdate.newCameraPosition(
              //     CameraPosition(zoom: 15,
              //         target: LatLng(position.latitude, position.longitude))));
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      new CameraPosition(
                          bearing: 0,
                          target: LatLng(position.latitude, position.longitude),
                          tilt: 0,
                          zoom: 18.00)));
            },
            onCameraIdle: (){
              print('newCameraMoveTo.target.longitude');
                    if(!widget.showItems){
                      if(newCameraMoveTo==null)return;

                      _geoCoder(newCameraMoveTo.target.latitude,newCameraMoveTo.target.longitude,data: Provider.of<WorkShopOrderProvider>(context,listen: false));
                    }
          },
            onCameraMove: (CameraPosition value) {

              newCameraMoveTo=value;
              // bool isMoving=true;
              //
              // Future.delayed(Duration(seconds: 3), () {
              //   if (!widget.showItems && !isMoving) {
              //     isMoving=true;
              //     print("hhelll");
              //     // _geoCoder(value.target.latitude,value.target.longitude);
              //   }
              // });
              //
              // isMoving=false;
              //
            },

          ),
          Center(child: Icon(Icons.location_on,color: blue,size: 40,),),
          widget.showItems ?   Align(alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(width: 50,),
                Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                  child: InkWell(
                    onTap: (){
                      if(newCameraMoveTo!=null){
                        Navigator.pop(context,[newCameraMoveTo.target.latitude,newCameraMoveTo.target.longitude]);
                      }
                    },
                    child: Container(
                      height: 55,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: themeColor,
                      ),
                      child: Center(child: Text("Confirm Address".tr,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 20))),
                    ),
                  ),
                ),
              ),
              Container(width: 50,)
            ],),
          ) : Container(),
          Align(
            alignment: Alignment(0.93,-0.5),
            child: InkWell(
              onTap: (){
                if(maptype==MapType.normal){
                  maptype=MapType.satellite;
                }
                else{
                  maptype=MapType.normal;
                }
                setState(() {

                });
              },
              child: Container(
                // height: 25,
                // width: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.map_rounded),
                )),
            ),
          ),
          Align(
            alignment: Alignment(0.93,-0.9),
            child: InkWell(
              onTap: (){
               if(_controller!=null){
                 getCurrentLocation();
               }
                setState(() {

                });
              },
              child: Container(
                // height: 25,
                // width: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.gps_fixed_outlined),
                )),
            ),
          ),

          // Align(
          //   alignment: Alignment(0.95,GetPlatform.isIOS? 0.89: 0.7 ),
          //   child: FloatingActionButton(
          //       backgroundColor: Colors.grey,
          //       child: Icon(Icons.location_searching),
          //       onPressed: () {
          //         getCurrentLocation();
          //       }),
          // )
        ],
      ),

    );
  }

  void _geoCoder(double lat, double lng,{WorkShopOrderProvider data}) async {
    print(lat);
    print(lng);
    data.setLatLong(lat,lng);

   final coordinates = new Coordinates(lat, lng);
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Address address = addresses.first;
    print(address.addressLine);
    data.setAddress(address.addressLine);
  }

}
