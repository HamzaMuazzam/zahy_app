import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/validator.dart';
import 'package:provider/provider.dart';

class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder, provider, _) {
      return Scaffold(
        backgroundColor: screenBgColor,
        appBar: AppBar(
          backgroundColor: screenBgColor,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          title: Text(
            'Invite'.tr,
            style: TextStyle(
              color: headingTextColor,
              fontSize: Get.height * .026,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * .02,
                      horizontal: Get.width * .06,
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
                        inviteSelectionWidget(0, 'Provider'.tr, provider),
                        inviteSelectionWidget(1, 'Client'.tr, provider),
                      ],
                    ),
                  ),
                  Form(
                    key: provider.inviteFormKey,
                    // autovalidate: provider.autoValidate,
                    child: _textFormFiled(0, 'Mobile number'.tr,
                        provider.inviteMobileNumberController, provider),
                  ),
                ],
              ),
              inviteButton(provider),
            ],
          ),
        ),
      );
    });
  }

  Widget _textFormFiled(
    int index,
    String label,
    TextEditingController tc,
    DashboardProvider provider,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height * .02,
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: Get.height * .02,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        controller: tc,
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
        enabled: true,
        keyboardType: TextInputType.phone,
        validator: FieldValidator.validatePhoneNumber,
      ),
    );
  }

  inviteButton(DashboardProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.inviteScreenOnInviteTapped();
      },
      child: Container(
        width: Get.width,
        height: Get.height * .07,
        margin: EdgeInsets.symmetric(vertical: Get.height * .03),
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
          'Invite'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  inviteSelectionWidget(int index, name, DashboardProvider provider) {
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.inviteScreenInviteSelection = index;
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: provider.inviteScreenInviteSelection == index
                        ? themeColor
                        : Color(0xff6F7D95),
                    width: 1,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: provider.inviteScreenInviteSelection == index
                          ? themeColor
                          : Colors.transparent),
                ),
              ),
              SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(
                  color: Color(0xff1E1E1E).withOpacity(.70),
                  fontSize: Get.height * .02,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * .017),
        ],
      ),
    );
  }
}
