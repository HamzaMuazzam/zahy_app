import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/lib/my_cars_screens.dart';
import 'package:musan_client/src/provider/MyCarsScreenProvider.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:provider/provider.dart';


void main(){
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MyCarsScreenProvider()),
      ChangeNotifierProvider(create: (context) => WorkShopOrderProvider()),

    ],child: MyCarsScreenNewDesign(),)
  ));
}