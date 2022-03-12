
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'utils.dart';
import 'car_location_screen.dart';
import 'car_model_screen.dart';

class IssueTypeScreen extends StatefulWidget {
  const IssueTypeScreen({Key key}) : super(key: key);

  @override
  _IssueTypeScreenState createState() => _IssueTypeScreenState();
}

class _IssueTypeScreenState extends State<IssueTypeScreen> {
  bool onTapIssueTypeList = true;

  bool checkItemSelectedOrNot(int id, WorkShopOrderProvider data){
    for(int i= 0;i<data.selectedIssuesList.length;i++){
      if(data.selectedIssuesList[i]==id){
        return true;
      }
    }
    return false;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices.getFaults(Get.context);
    analytics.logScreenView(screenName: "IssueTypeScreen",screenClass:"IssueTypeScreen");


}
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkShopOrderProvider>(builder: (builder,data,child){
      return   Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: backgroundBlue,
          child:data.isFaultsLoaded
              ?
          Column(
            children: [
              /// Animation bar using containers in a row.
              Expanded(
                  flex: 1,
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      child: stepBar(isFirstTickToshow: true,)
                  )
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)
                        )
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22,right: 22,top: 22,),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step 2 of 4'.tr,
                              style: TextStyle(
                                  color: blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              'Issue type'.tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              'You can select multiple options'.tr,
                              style: TextStyle(
                                  color: textGreyColor,
                                  fontSize: 18
                              ),
                            ),
                            Container(
                              height: Get.height*0.4,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: -12.0,
                                    blurRadius: 12.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListView.builder(
                                itemCount: data.faultsReponse.result.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: InkWell(
                                        onTap: (){
                                          print(data.selectedIssuesList);

                                          if(data.selectedIssuesList.length==0) {
                                            data.selectedIssuesList.add(data.faultsReponse.result[index].id);
                                            setState(() {});
                                          }
                                          else if (data.selectedIssuesList.length!=0){
                                            for(int i=0;i<data.selectedIssuesList.length;i++){
                                              if(data.selectedIssuesList[i]==data.faultsReponse.result[index].id){
                                                data.selectedIssuesList.remove(data.faultsReponse.result[index].id);
                                                setState(() {});
                                                return;
                                              }
                                            }
                                            data.selectedIssuesList.add(data.faultsReponse.result[index].id);
                                            setState(() {});
                                          }

                                        },
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color:checkItemSelectedOrNot(data.faultsReponse.result[index].id,data) ? yellowShade :  blueShade,
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 12,),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: checkItemSelectedOrNot(data.faultsReponse.result[index].id,data) ? yellow: Colors.white,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              SizedBox(width: 8,),
                                              Text(
                                                '${data.faultsReponse.result[index].name}',
                                                style: TextStyle(
                                                    fontSize: 18
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            /// Row for tow buttons. Cancel and Next buttons.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: customCancelbackbutton()
                                ),
                                InkWell(
                                    onTap: (){
                                      if(data.selectedIssuesList.isNotEmpty){
                                        Get.to(CarModelScreen());
                                      }
                                    },
                                    child: onTapIssueTypeList? customNextButton(color: textGreyColor):
                                    customNextButton()
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
                  )
              ),
            ],
          )
              :
          Center(child: CircularProgressIndicator())
        ),
      ) ;
    });
  }


}