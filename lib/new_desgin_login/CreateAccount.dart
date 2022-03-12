import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import 'MobileVerification.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController firsName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                child: Center(
                  child: Text(
                    'Create account'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
            ),
            Expanded(
                flex: 9,
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    children: [
                      Container(
                        height: Get.height/12,
                        width: Get.width/1.1,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: firsName,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18
                            ),
                            decoration: InputDecoration(
                                hintText: 'First name'.tr,
                                hintStyle: TextStyle(color: Colors.blueGrey,),
                                border: InputBorder.none

                                // enabledBorder: UnderlineInputBorder(
                                //   borderSide: BorderSide(
                                //     color: Colors.grey.shade200,
                                //   ),
                                // ),
                                // focusedBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(
                                //         color: Colors.grey.shade200
                                //     )
                                // )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: Get.height/12,
                        width: Get.width/1.1,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: lastName,
                            style: TextStyle(
                              color: Colors.blueGrey,
                                fontSize: 18

                            ),
                            decoration: InputDecoration(
                                hintText: 'Last name'.tr,
                                hintStyle: TextStyle(color: Colors.blueGrey,
                                    fontSize: 18
                                ),
                                border: InputBorder.none

                              // enabledBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Colors.grey.shade200,
                              //   ),
                              // ),
                              // focusedBorder: UnderlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: Colors.grey.shade200
                              //     )
                              // )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 2,
                child: InkWell  (
                  onTap: () async{

                    if(firsName.text.isEmail || lastName.text.isEmpty){
                      return;
                    }

                    var data=Provider.of<LoginProvider>(context,listen: false);
                    data.setName("${firsName.text} ${lastName.text}");
                    Map<String, String> body = {
                      'Name': '${data.userName}',
                      'PhoneNumber': '${data.userMobileNumber}',
                      'Password': '123456789',
                      'Type': '1',
                      'Email': 'demoEail',
                      'FCMToken': 'noToken',
                      'SpecializationId': '1',
                      'IndustryId': '1',
                      'CityId': '1',
                      'Address': 'No Address Associated',
                      'Latitude': '0',
                      'Longitude': '0'
                    };
                    logger.e(body);
                    analytics.logSignUp(signUpMethod: "MOBILE_NUMBER_SIGN_UP");
                    Get.dialog(Center(child: CircularProgressIndicator(),));
                   await  ApiServices.signUpUser(body, Get.context);

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 32,bottom: 32),
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Create Account'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
