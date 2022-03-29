
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';

import 'package:provider/provider.dart';

class AwesomeDropdownForFiltrationOrder extends StatefulWidget {


  @override
  _AwesomeDropdownForFiltrationOrderState createState() => _AwesomeDropdownForFiltrationOrderState();
}

class _AwesomeDropdownForFiltrationOrderState extends State<AwesomeDropdownForFiltrationOrder> {
  List<String> textList =["Filter Reset".tr,"Completed".tr, "In Progress".tr,"Rejected".tr];


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
            Text(data.filterOrders.replaceAll("Reset".tr, ""),textAlign:TextAlign.center,style: TextStyle(color: black,fontSize: 18),),
            Icon(Icons.keyboard_arrow_down,size: 25,color: black,),
          ],
        ),
        onSelected: (v) {
          setState(() {
            data.setFilterForOrders(v);
            

          });
        },
      );
    });
  }
}