import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/locale/constantString.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import 'MobileVerification.dart';

class EnterYourNumber extends StatefulWidget {
  const EnterYourNumber({Key key}) : super(key: key);

  @override
  _EnterYourNumberState createState() => _EnterYourNumberState();
}

class _EnterYourNumberState extends State<EnterYourNumber> {

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshop) {
          return Consumer<LoginProvider>(builder: (builder, data, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.white,
                child: Column(
                  children: [

                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(onPressed: (){
                                Get.back();
                              },icon: Icon(Icons.arrow_back,color: Colors.black,),),
                            ),
                            SizedBox(width: Get.width / 4),
                            Text(
                              'Enter your number'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),

                    Expanded(
                        flex: 9,
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height / 12,
                                  width: Get.width / 1.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.brown),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      /// Text country number
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: Text(
                                          '+966',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        height: Get.height / 30,
                                        width: 1,
                                        color: Colors.grey.shade600,
                                      ),
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 5),
                                              child: TextFormField(
                                                controller: numberController,
                                                textDirection: TextDirection.ltr,
                                                autofocus: true,
                                                onChanged: (phone){
                                                  if(phone.length==9){
                                                    FocusScope.of(context).unfocus();
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: "Phone Number".tr,
                                                    hintTextDirection: TextDirection.ltr,

                                                    hintStyle: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 16)),
                                              )))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  'we will send you a SMS code to verify your number'.tr,
                                  style: TextStyle(
                                      color: Colors.grey.shade600, fontSize: 15),
                                ),
                                SizedBox(height: 50,),
                                InkWell(
                                  onTap: () {
                                    data.setUserMobileNumner("+966${numberController.text}");

                                    if (data.userMobileNumber.isEmpty ||
                                        data.userMobileNumber.length < 10) {
                                      TOASTS("Empty/Invalid Number".tr);
                                      return;
                                    }

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return MobileVerification();
                                        }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    child: Container(
                                      height: Get.height *0.08,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(20)),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Continue'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )),

                  ],
                ),
              ),
            );
          });
        });
  }


}
