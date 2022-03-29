
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';

import 'package:provider/provider.dart';

class AwesomeDropdownForFiltrationOffer extends StatefulWidget {


  @override
  _AwesomeDropdownForFiltrationOfferState createState() => _AwesomeDropdownForFiltrationOfferState();
}

class _AwesomeDropdownForFiltrationOfferState extends State<AwesomeDropdownForFiltrationOffer> {
  List<String> textList =["Filter Reset".tr,"0 Offer".tr, "Having Offers".tr];


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
                Expanded(child: Text(str.replaceAll("Filter".tr, ""),)),
              ],),
            );
          }).toList();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(data.filteroffers.replaceAll("Reset".tr, ""),textAlign:TextAlign.center,style: TextStyle(color: black,fontSize: 18),),
            Icon(Icons.keyboard_arrow_down,size: 25,color: black,),
          ],
        ),
        onSelected: (v) {
          setState(() {
            data.setFilterForOffers(v);
            

          });
        },
      );
    });
  }
}