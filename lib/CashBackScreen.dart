import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:provider/provider.dart';

import 'src/provider/dashboard_provider.dart';

class CashBackScreen extends StatefulWidget {
  const CashBackScreen({Key key}) : super(key: key);

  @override
  _CashBackScreenState createState() => _CashBackScreenState();
}

class _CashBackScreenState extends State<CashBackScreen> {
  bool isOK =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,()async{
      isOK = await ApiServices.getCashBack();
      if(!isOK){
        isOK =false;
        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context,data,child) {
        return Scaffold(
          appBar: AppBar(title: Text("Cashback".tr),),
          body:
          data.isCashBackLoaded? Container(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You have Cashback of: ".tr,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("SR".tr+" ${data.promotionCashBackFromJson.result.amount}".tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: blue),),
                    ),

                  ],
                ),
          )
            :
          isOK ?
          Center(
                child: CircularProgressIndicator(),
              ):Container(),
      );
    });
  }
}
