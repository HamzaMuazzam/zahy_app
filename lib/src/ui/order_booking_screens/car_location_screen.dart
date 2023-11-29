import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/GoogleMap.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_model_screen.dart';
import 'package:musan_client/src/ui/order_booking_screens/issue_type_screen.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:provider/provider.dart';

class CarLocationScreen extends StatefulWidget {
  int isTechnicianOrder;
  bool isFromDicountOffers;
  int offerID;

  CarLocationScreen(
      {this.isTechnicianOrder, this.isFromDicountOffers: false, this.offerID});

  @override
  _CarLocationScreenState createState() => _CarLocationScreenState();
}

class _CarLocationScreenState extends State<CarLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytics.logScreenView(
        screenName: "CarLocationScreen", screenClass: "CarLocationScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkShopOrderProvider>(builder: (builder, data, child) {
      /// 0 for technician
      ///  1 for workshop
      data.setOrderTyepe(
          widget.isTechnicianOrder, widget.offerID, widget.isFromDicountOffers);

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: backgroundBlue,
          child: Column(
            children: [
              ///      Animation bar using containers in a row.
              Expanded(
                  flex: 1,
                  child: Container(
                      height: Get.height, width: Get.width, child: stepBar())),
              Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Step 1 of 4'.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Car Location'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Please enter your car location on the map'.tr,
                              style:
                                  TextStyle(color: textGreyColor, fontSize: 17),
                            ),

                            /// Container for search placees on the map.
                            Container(
                              decoration: BoxDecoration(
                                  color: blueShade,
                                  borderRadius: BorderRadius.circular(8)),
                              child: InkWell(
                                onTap: () {
                                  // Get.to( () => GMaps(title: "Location".tr,)).then((value) {
                                  //   print("Address Values: $value");
                                  //   if(!value.toString().contains("null")){
                                  //     logger.e("weeeeeee");
                                  //     data.setLatLong(double.parse(value[0].toString()),double.parse(value[1].toString()));
                                  //     _geoCoder(double.parse(value[0].toString()),double.parse(value[1].toString()),data: data);
                                  //   }
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        // width: Get.width/1.5,
                                        child: TextFormField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              text: '${data.address}'),
                                          decoration: InputDecoration(
                                              hintText: 'Search for places'.tr,
                                              hintStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 18),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black38,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
SizedBox(
  height: 10,
),
                            /// Container for Map view
                            Container(
                                height: Get.height / 2,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(6)),
                                alignment: Alignment.center,
                                child: GMaps(title: '', showItems: false)),
                            SizedBox(
                              height: 8,
                            ),

                            /// Row for tow buttons. Cancel and Next buttons.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: customCancelbackbutton()),
                                InkWell(
                                  onTap: () {
                                    if (data.latitude == 0 ||
                                        data.longitude == 0) {
                                      return;
                                    }
                                    if (data.screenChecked == 0) {
                                      data.selectedIssuesList.clear();
                                      Get.to(CarModelScreen());
                                    } else {
                                      Get.to(IssueTypeScreen());
                                    }
                                  },
                                  child: customNextButton(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
