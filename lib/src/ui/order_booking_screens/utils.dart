import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color blue = Color(0xFF075AFD);
Color yellowShade = Color(0xFFFAF1D4);
Color yellow = Color(0xFFE8BC2A);
Color blueShade = Color(0xFFEDF2F5);
Color greyShade = Colors.grey.shade400;
Color textGreyColor = Color(0xFF7A8F99);
Color backgroundBlue = Color(0xFFBFEAFF);
// const Color white = Color(0xFFFFFFFF);
const Color lightGrey = Color(0xFFF1F1F1);
const Color midGrey = Color(0xFF6F7D95);
const Color deepGrey = Color(0xFFF3F3F3);
const Color black = Color(0xFF000000);

const Color red = Color(0xFFE73939);
const Color green = Color(0xFF17CE3F);
const Color light_green = Color(0xFF00E592);
const Color orangeYellow = Color(0xFFE8BC2A);
const Color white = CupertinoColors.white;
const Color grey = Color(0xFFB1B1B1);
const Color greylight = Color(0xFFBFBFBF);
const Color icon_grey_color = Color(0xFFCED5D9);
const Color textgreyColor = Color(0xFF7A8F99);
const Color lineColor = Color(0xFFE8E8E8);




Widget stepBar({
  bool isFirstTickToshow = false,
  bool isSecondTickToshow = false,
  bool isThirdTickToshow = false,
  bool isFourthTickToshow = false,
})
{
  return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Center(
                child: Container(
                  color: blue,
                  height: 2,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isFirstTickToshow
                  ? Container(
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      )
                    )
                  : Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.blue.shade300, width: 3)),
                    ),
                  isSecondTickToshow
                  ? Container(
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      ))
                  : Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.blue.shade300, width: 3)),
                    ),
                  isThirdTickToshow
                  ? Container(
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      ))
                  : Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.blue.shade300, width: 3)),
                    ),
                  isFourthTickToshow
                  ? Container(
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      ))
                  : Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.blue.shade300, width: 3)
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      )
  );

}

Widget customNextButton({Color color: blue,String text:'Next'}){
  return Container(
      height: 60,
      width: Get.width*0.45,
      decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          ),
          Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
        ],
      )
  );
}


Widget customCancelbackbutton(){
  return Container(
      height: 60,
      width: Get.width*0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios,color: textGreyColor,size: 15,),
            Text(
              'Back'.tr,
              style: TextStyle(
                  color: textGreyColor,
                  fontSize: 18
              ),
            ),
          ],
        ),
      )
  );
}