import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';

import 'package:provider/provider.dart';

class AwesomeDropdownForSorting extends StatefulWidget {
  @override
  _AwesomeDropdownForSortingState createState() => _AwesomeDropdownForSortingState();
}

class _AwesomeDropdownForSortingState extends State<AwesomeDropdownForSorting> {
  final List<String> textList = [
    "Sort Reset".tr,
    "By Time &  Days".tr,
    "By Average Price".tr,
    "By Date".tr
  ];
  // String _currentItemSelected;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Consumer<OrderScreenProvider>(builder: (builder,data,child){
      return PopupMenuButton<String>(
        itemBuilder: (context) {
          return textList.map((str) {

            return PopupMenuItem(
              value: str.replaceAll("Reset".tr, ""),
              child: Row(children: [
                Expanded(child: Text(str.replaceAll("Sort".tr, ""))),
              ],),
            );
          }).toList();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(data.sortoffers.replaceAll("Reset".tr, ""),textAlign:TextAlign.center,style: TextStyle(color: black,fontSize: 18),),
            Icon(Icons.keyboard_arrow_down,size: 25,color: black,),
          ],
        ),
        onSelected: (v) {
          setState(() {
            data.setsortOffers(v);
          });
        },
      );
    });
  }
}