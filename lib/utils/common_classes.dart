import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;



Widget dropDown(int indexNumbr){

  var provider = Provider.of<WorkShopOrderProvider>(Get.context,listen: false);
  return  Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
    ),
    child: DropdownButton(
      dropdownColor: Colors.white,
      isExpanded: true,
      value: provider.getDropDownInitValue(indexNumbr),
      style:TextStyle(fontSize: 14,color: Colors.grey.shade50),
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      underline: Container(color: Colors.transparent),
      onChanged: (newValue) {
          provider.setDropDownInitValue(indexNumbr, newValue);
      },
      items: provider.dropDownValues(indexNumbr).map((value) {
        return DropdownMenuItem(

          child: Container(

            margin: EdgeInsets.only(left: 4, right: 4),
            child: Text(value,
                style:
                TextStyle(fontSize: 14, color: Colors.black)),
          ),
          value: value,
        );
      }).toList(),
    ),
  );

}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({
    Key key,
    this.value,
    this.onChanged})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value ? Alignment.centerLeft :Alignment.centerRight).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            setState(() {

            });
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 45.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation.value ==
                  Alignment.centerLeft
                  ? Colors.grey
                  : Colors.blue,),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child:  Container(
                alignment: widget.value
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

TOASTS(String data, {double fontsize = 16.0,}) {
  Fluttertoast.showToast(
      msg: data,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: fontsize);
}

Widget showShimmer(){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      width: Get.width,
      decoration: BoxDecoration(
          // color: Colors.white, borderRadius: BorderRadius.circular(35),
          // boxShadow: [BoxShadow(color: greylight,spreadRadius: 1,blurRadius: 5)]
      ),
      child:  Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.5),
          highlightColor: Colors.blue.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 100,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 200,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 250,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: Get.width,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 250,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 250,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 200,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 100,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: Get.width,color: red,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 15,width: 250,color: red,),
                  ),





                ],),
            ),
          )
      ),
    ),
  );
}
var logger = Logger();


extension Target on Object {
  bool isAndroid() {
    return Platform.isAndroid;
  }
  bool isIOS() {
    return Platform.isIOS;
  }
  bool isLinux() {
    return Platform.isLinux;
  }
  bool isWindows() {
    return Platform.isWindows;
  }
  bool isMacOS() {
    return Platform.isMacOS;
  }
  bool isWeb() {
    return kIsWeb;
  }
// ···
}

void openImage(String imageLink) {
  Get.dialog(Center(
      child: SizedBox(
        height: Get.height / 2,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: NetworkImage(imageLink), fit: BoxFit.fill)),
          ),
        ),
      )));
}