import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class AdditionalInformationScreen extends StatefulWidget {
  const AdditionalInformationScreen({Key key}) : super(key: key);

  @override
  _AdditionalInformationScreenState createState() =>
      _AdditionalInformationScreenState();
}

  class _AdditionalInformationScreenState extends State<AdditionalInformationScreen> {

  final picker = ImagePicker();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytics.logScreenView(screenName: "AdditionalInformationScreen",screenClass:"AdditionalInformationScreen");

}
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkShopOrderProvider>(builder: (builder, data, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.blue.shade100,
          child: Column(
            children: [
              /// Animation bar using containers in a row.
              Expanded(
                  flex: 1,
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      child: stepBar(
                          isFirstTickToshow: true,
                          isSecondTickToshow: true,
                          isThirdTickToshow: true))),
              Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 22,
                        right: 22,
                        top: 22,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 4 of 4'.tr,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Additional information'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Upload some photos & leave a note if you want'
                                  .tr,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: Get.height * 0.6,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.bottomSheet(uploadphotosbottomSheet(data));
                                      },
                                      child: Container(
                                          // height: Get.height / 3.5,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              color: blueShade,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.cloud_upload_outlined,
                                                  color: blue,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                'Upload photos'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Text(
                                                'Please upload photos of your issue to help workshops'
                                                    .tr,
                                                style: TextStyle(
                                                  color: textGreyColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 15,)
                                            ],
                                          )),
                                    ),
                                    data.isImageSelected
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(
                                                    data.imageList.length,
                                                    (index) => uploadedPhotos(
                                                        data.imageList[index])),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: blueShade,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 18.0),
                                            child: TextFormField(
                                              controller: TextEditingController(text: data.freeComment),
                                              onTap: () {
                                                Get.forceAppUpdate();
                                              },
                                              style: TextStyle(
                                                fontSize: Get.height * .02,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                              onChanged: (value){

                                                data.setFreeComment(value);

                                              },
                                              textInputAction: TextInputAction.done,
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  hintText: 'Write a note'.tr,
                                                  hintStyle: TextStyle(
                                                    color: textGreyColor,
                                                    fontSize: 18,
                                                  ),
                                                  border: InputBorder.none),
                                            ))),
                                  ],
                                ),
                              ),
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
                                      data.submitOrder(context,data.screenChecked,data.isFromDicountOffers,data.offerID);
                                    },
                                    child: customNextButton(text: 'Order'.tr)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              ]
            )
          )
        );
      }
    );
  }

  Widget uploadphotosbottomSheet(data) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _imgFromCamera(context, data);
                      },
                      child: Container(
                        width: Get.width,
                        child: Center(
                          child: Text(
                            'Open Camera'.tr,
                            style: TextStyle(color: blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: Get.width,
                    color: greyShade,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          // Get.to(UploadphotoScreen());

                          _imgFromGallery(context, data);
                        },
                        child: Container(
                          width: Get.width,
                          child: Center(
                            child: Text(
                              'Photo Roll'.tr,
                              style: TextStyle(color: blue),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(color: textGreyColor),
                ),
              ),
            ),
            SizedBox(height: 18)
          ],
        ),
      ),
    );
  }

  Widget uploadedPhotos(PickedFile imageList) {
    return Container(
      margin: EdgeInsets.only(right: 4, top: 4),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: FileImage(File(imageList.path)),
          ),
          borderRadius: BorderRadius.circular(12)),
    );
  }

  _imgFromCamera(BuildContext context, WorkShopOrderProvider data) async {
    Get.back();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      data.setImageSeletedOrNot(true);
      data.setSelectedImage(pickedFile);
    }
  }

  _imgFromGallery(BuildContext context, WorkShopOrderProvider data) async {
    Get.back();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      data.setImageSeletedOrNot(true);
      data.setSelectedImage(pickedFile);
    }
  }

}
