import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/validator.dart';

class OrderFromReportService extends StatefulWidget {
  Report report;
  OrderFromReportService(this.report);



  @override
  _OrderFromReportServiceState createState() => _OrderFromReportServiceState(this.report);
}

class _OrderFromReportServiceState extends State<OrderFromReportService> {
  TextEditingController locationController = TextEditingController();

  Report report;
  _OrderFromReportServiceState(this.report);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:orderButton(),
      backgroundColor: screenBgColor,
      appBar: AppBar(
        backgroundColor: screenBgColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          'Order From Report'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * .01,
            horizontal: Get.width * .06,
          ),
          child: Column(
            children: [
              _textFormFiled(0, report.addressLocation.length==0 ? "Your location".tr : report.addressLocation),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02,
                  horizontal: Get.width * .08,
                ),
                margin: EdgeInsets.only(
                  bottom: Get.height * .02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(.13),
                      spreadRadius: .08,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report'.tr,
                      style: TextStyle(
                        color: headingTextColor,
                        fontSize: Get.height * .019,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Issue type'.tr,
                          style: TextStyle(
                            color: Color(0xff1E1E1E).withOpacity(.70),
                            fontSize: Get.height * .018,
                          ),
                        ),
                        SizedBox(height: Get.height * .007),
                        Text(
                          // getAllissue(resultlist[num].orderHistory[0].issues),
                          getAllissue(report.issueTypes.length==0 ? [] : report.issueTypes),
                          style: TextStyle(
                            color: themeColor,
                            fontSize: Get.height * .022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location'.tr,
                          style: TextStyle(
                            color: Color(0xff1E1E1E).withOpacity(.70),
                            fontSize: Get.height * .018,
                          ),
                        ),
                        SizedBox(height: Get.height * .007),
                        Text(
                          report.addressLocation,
                          style: TextStyle(
                            color: themeColor,
                            fontSize: Get.height * .022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comment'.tr,
                          style: TextStyle(
                            color: Color(0xff1E1E1E).withOpacity(.70),
                            fontSize: Get.height * .018,
                          ),
                        ),
                        SizedBox(height: Get.height * .007),
                        Text(
                          report.comment.length==0 ? " " : report.comment,
                          style: TextStyle(
                            color: themeColor,
                            fontSize: Get.height * .022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormFiled(
    int index,
    String label,

  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * .02,
        top: Get.height * .01,
      ),
      child: TextFormField(
        onTap: () {
          Get.forceAppUpdate();
        },

        style: TextStyle(
          fontSize: Get.height * .02,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          hintStyle: TextStyle(
              fontSize: Get.height * .018,
              color: Color(0xff2C4752).withOpacity(.30)),
          suffixIcon:
              Icon(Icons.location_on_outlined, color: themeColor, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          errorStyle: TextStyle(fontSize: Get.height * .014),
        ),
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        enabled: false,
        // keyboardType:
        //     TextInputType.numberWithOptions(signed: true, decimal: true),
        keyboardType: TextInputType.text,
        validator: FieldValidator.thisField,
      ),
    );
  }

  orderButton() {
    return GestureDetector(
      onTap: (){
        ApiServices.orderFromReport(report.reportId.toString());
      },
      child: Container(
        width: Get.width,
        height: Get.height * .065,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .01,
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
          'Order'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }
  String getAllissue(List<IssueType> issues){

    List<String> data=[];
    for(int i=0;i<issues.length;i++){
      data.add(issues[i].faultName);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

}
