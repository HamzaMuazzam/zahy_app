import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/images.dart';
import 'package:musan_client/utils/validator.dart';
import 'package:provider/provider.dart';

import '../order_booking_screens/utils.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File image=new File(" ");
  bool isImageSelectedFromLocal=false;
  
  String
  firstname="",
      lastNAme="",
      email="",
      mobileNumber="";



  @override
  void initState() {
    analytics.logScreenView(screenName: "EditProfile",screenClass:"EditProfile");

    var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
    if(dashboardProvider.isUserProfileLoaded){

    }
    else{
      ApiServices.loadUserProfile(dashboardProvider.userID);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder, provider, _) {
      return Scaffold(

        bottomNavigationBar: saveChangesButton(provider),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeColor,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: white, size: 28),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          title: Text(
            'Edit Profile'.tr,
            style: TextStyle(
              color: white,
              fontSize: Get.height * .026,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:
          provider.isUserProfileLoaded ?
          Form(
            key: provider.editProfileFormKey,
            child: Stack(
              children: [
                Container(
                    width: Get.width,
                    height: 219,
                    child: SvgPicture.asset("assets/images/curved.svg",fit: BoxFit.fitWidth,)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 170),
                    GestureDetector(
                      onTap: (){
                        provider.getGallery().then((value){
                          image=value;
                          isImageSelectedFromLocal=true;
                          setState(() {

                          });
                        });
                      },
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(image: isImageSelectedFromLocal ? AssetImage(image.path,)
                              :
                          NetworkImage(
                              "https://muapi.deeps.info/${provider.userProfileFromJson.result.displayPicture}"),
                              fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(.13),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Upload a new photo'.tr,
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Get.height * .02,
                      ),
                    ),
                    SizedBox(height: 20),
                    _textFormFiled(
                        0,
                        'First Name'.tr,
                        provider.editProfileFirstNameController,
                        provider,
                        (value) {
                          firstname=value;
                        }),
                    _textFormFiled(
                        1,
                        'Last Name'.tr,
                        provider.editProfileLastNameController,
                        provider,
                        (value) {
                          lastNAme=value;
                        }),
                    _textFormFiled(2, 'Email'.tr, provider.editProfileEmailController,
                        provider, (value) {
                          email=value;

                        }),
                    _textFormFiled(3, 'Mobile Number'.tr,
                        provider.editProfileNumberController, provider, (value) {
                          mobileNumber=value;

                        }),
                  ],
                ),
              ],
            ),
          )
              :
          Center(child: CircularProgressIndicator(),),
        ),
      );
    });
  }

  saveChangesButton(DashboardProvider provider) {
    return GestureDetector(
      onTap: () {

        if(provider.editProfileFirstNameController.text.length==0 ||provider.editProfileLastNameController.text.length==0
            ||
            provider.editProfileEmailController.text==0
            ||
            provider.editProfileNumberController.text==0){
          Get.snackbar("Error".tr, "Please compelete the forms".tr);
          return;
        }
        else{
          ApiServices.updateUserSettings(provider.editProfileFirstNameController.text
              ,provider.editProfileLastNameController.text,
              provider.editProfileEmailController.text,provider.editProfileNumberController.text,image);
        }

      },
      child: Container(
        width: Get.width,
        height: Get.height * .065,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .06,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Text(
          'Save changes'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  Widget _textFormFiled(
    int index,
    String label,
    TextEditingController tc,
    DashboardProvider provider,
      Function ONCHANGE
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * .02,
        left: Get.width * .06,
        right: Get.width * .06,
      ),
      child: TextFormField(

        onTap: () {
          Get.forceAppUpdate();
        },
        onChanged: ONCHANGE,
        style: TextStyle(
          fontSize: Get.height * .02,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        controller: tc,
        textInputAction:
            index == 3 ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          // hintStyle: TextStyle(
          //     fontSize: Get.height * .018,
          //     color: Color(0xff00b6ff).withOpacity(.30)),
          border: OutlineInputBorder(

              borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(5)
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),

          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),

          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.3)),

          ),
          errorStyle: TextStyle(fontSize: Get.height * .014),
        ),
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        enabled: true,
        // keyboardType:
        //     TextInputType.numberWithOptions(signed: true, decimal: true),
        keyboardType: TextInputType.text,
        validator: index == 3
            ? FieldValidator.validatePhoneNumber
            : FieldValidator.thisField,
      ),
    );
  }
}
