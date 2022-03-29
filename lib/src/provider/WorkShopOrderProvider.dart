import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/CarInformationReponse.dart';
import 'package:musan_client/api_services/response_models/CarInformationReponse.dart'
    as res;
import 'package:musan_client/api_services/response_models/CarRelatedInfoReponse.dart';
import 'package:musan_client/api_services/response_models/FaultsReponse.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkShopOrderProvider extends ChangeNotifier {
  FaultsReponse faultsReponse;
  var address = "Address".tr;

  bool isFaultsLoaded = false;

  CarRelatedInfoReponse carRelatedInfoReponse;
  List<int> selectedIssuesList=[];

  int selectedCarIndex=-1;

  bool isCarRelatedDataLoaded = false;

  String carTypeString = "Car type".tr;

  String carCompanyString = "Company".tr;

  String carColorString = "Color".tr;

  String carModelString = "Model".tr;

  String carTransmition = "Gear transmission".tr;
  String carModelName= "Car model name".tr;
  bool isExpanded = true;

  bool isNewCarAdded = false;
  bool isUserCarsLoaded = false;
  CarInformationReponse carInformationReponseFromJsonByUserID;

  List<String> userCars = [];
  String initValueForSelectACar = "Select a car".tr;
  bool isImageSelected = false;

  // PickedFile imageFile = new PickedFile(" ");
  List<PickedFile> imageList = [];
  String freeComment = "";

  // List<String> issuetypesList = <String>[];

  double latitude = 0;
  double longitude = 0;

  setLatLong(double lat, double lng) {
    this.latitude = lat;
    this.longitude = lng;
  }

  setAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  setFaultsResponse(bool isFaultsLoaded, FaultsReponse faultsReponse) {
    this.faultsReponse = faultsReponse;
    this.isFaultsLoaded = isFaultsLoaded;
    notifyListeners();
  }

  setCarRelatedDataResponse(bool isCarRelatedDataLoaded,
      CarRelatedInfoReponse carRelatedInfoReponse) {
    this.carRelatedInfoReponse = carRelatedInfoReponse;
    this.isCarRelatedDataLoaded = isCarRelatedDataLoaded;
    notifyListeners();
  }

  List<String> dropDownValues(int indexNumbr) {
    print("Index Number is : $indexNumbr");
    List<String> dropList = [];

    var carTypes = carRelatedInfoReponse.result.carTypes;
    var carCompanies = carRelatedInfoReponse.result.carCompanies;
    var colors = carRelatedInfoReponse.result.colors;
    var models = carRelatedInfoReponse.result.models;


    if (indexNumbr == 1) {
      dropList.add("Car type".tr);

      carTypes.forEach((element) {
        dropList.add(element.typeName);
      });
    }
    else if (indexNumbr == 2) {
      dropList.add("Company".tr);

      carCompanies.forEach((element) {
        dropList.add(element.companyName);
      });
    }
    else if (indexNumbr == 3) {
      dropList.add("Color".tr);

      colors.forEach((element) {
        dropList.add(element.colorName);
      });
    }
    else if (indexNumbr == 4) {
      dropList.add("Model".tr);

      models.forEach((element) {
        dropList.add(element.modelName);
      });
    }
    else if (indexNumbr == 6) {
      dropList.add("Car model name".tr);
      carCompanies.forEach((element) {
        if(carCompanyString.toLowerCase()==element.companyName.toLowerCase()){
          var carModelNamesList = element.carModelNames;
          for(int  i=0;i<carModelNamesList.length;i++){
            dropList.add(carModelNamesList[i]);
          }

        }

      });

      // var modelsName = carRelatedInfoReponse.result.;


      // models.forEach((element) {
      //   dropList.add(element.);
      // });
    }
    else if (indexNumbr == 5) {
      dropList.add("Gear transmission".tr);
      dropList.add("Auto".tr);
      dropList.add("Manual".tr);
    }
    return dropList;
  }

  setDropDownInitValue(int indexNumbr, String changedValue) {

    if (indexNumbr == 1) {
      carTypeString = changedValue;
    }
    else if (indexNumbr == 2) {
      carCompanyString = changedValue;
    }
    else if (indexNumbr == 3) {
      carColorString = changedValue;
    }
    else if (indexNumbr == 4) {
      carModelString = changedValue;
    }
    else if (indexNumbr == 5) {
      carTransmition = changedValue;
    }
    else if (indexNumbr == 6) {
      carModelName = changedValue;
    }

    notifyListeners();

  }

  getDropDownInitValue(int indexNumbr) {
    if (indexNumbr == 1) {
      return carTypeString;
    }
    else if (indexNumbr == 2) {
      return carCompanyString;
    }
    else if (indexNumbr == 3) {
      return carColorString;
    } else if (indexNumbr == 4) {
      return carModelString;
    } else if (indexNumbr == 5) {
      return carTransmition;
    }else if (indexNumbr == 6) {
      return carModelName;
    }
  }

  Future addACar(BuildContext context) async {
    if (carTypeString != "Car type".tr &&
        carModelString != "Model".tr &&
        carTransmition != "Gear transmission".tr &&
        carColorString != "Color".tr &&
        carCompanyString != "Company".tr) {
      Get.dialog(Center(
        child: CircularProgressIndicator(),
      ));
      String companyID;

      for (int i = 0;
          i < carRelatedInfoReponse.result.carCompanies.length;
          i++) {
        if (carRelatedInfoReponse.result.carCompanies[i].companyName ==
            carCompanyString) {
          companyID =
              carRelatedInfoReponse.result.carCompanies[i].companyId.toString();
          break;
        }
      }
      String modelID;
      for (int i = 0; i < carRelatedInfoReponse.result.models.length; i++) {
        if (carRelatedInfoReponse.result.models[i].modelName ==
            carModelString) {
          modelID = carRelatedInfoReponse.result.models[i].modelId.toString();
          break;
        }
      }
      String colorId;
      for (int i = 0; i < carRelatedInfoReponse.result.colors.length; i++) {
        if (carRelatedInfoReponse.result.colors[i].colorName ==
            carColorString) {
          colorId = carRelatedInfoReponse.result.colors[i].colorId.toString();
          break;
        }
      }
      String typeId;
      for (int i = 0; i < carRelatedInfoReponse.result.carTypes.length; i++) {
        if (carRelatedInfoReponse.result.carTypes[i].typeName ==
            carTypeString) {
          typeId =
              carRelatedInfoReponse.result.carTypes[i].carTypeId.toString();
          break;
        }
      }

      SharedPreferences.getInstance().then((value) {
        var userID = value.getString(Finals.USER_ID);

        String body = '{"carTransmission": "$carTransmition",'
            '"companyId": $companyID,"modelId": $modelID,"colorId": $colorId,"userId": $userID,"carTypeId": $typeId,'
            '"carName": "$carCompanyString $carModelName $carTypeString $carColorString $carModelString"}';

        print("body $body");
        ApiServices.addACar(context, body);
      });
    }
    else {
      Get.snackbar("Incomplete".tr, "Please Select all Information".tr);
    }
  }

  setisNewCarAdded(bool value) {
    isNewCarAdded = value;
    notifyListeners();
  }

  setCarInformationByUserIDResponse(bool isUserCarsLoaded,
      CarInformationReponse carInformationReponseFromJson) {
    this.isUserCarsLoaded = isUserCarsLoaded;

    carInformationReponseFromJsonByUserID = carInformationReponseFromJson;
    userCars.clear();
    userCars.add("Select a car".tr);
    initValueForSelectACar = "Select a car".tr;
    for (int i = 0;
        i < carInformationReponseFromJsonByUserID.result.length;
        i++) {

      if (carInformationReponseFromJsonByUserID.result[i].carName != null) {
        if(i==0){
          initValueForSelectACar=carInformationReponseFromJsonByUserID.result[i].carName;
        }
        userCars.add(carInformationReponseFromJsonByUserID.result[i].carName);
      }
    }

    // Set set = userCars.toSet();
    //
    // userCars = set.toList();


    if(userCars.isNotEmpty){
      logger.e("userCars.isNotEmpty ${carInformationReponseFromJsonByUserID.result.length-1 }");
      selectedCarIndex = carInformationReponseFromJsonByUserID.result.length-1;
      notifyListeners();

    }
    print("userCars lenght: ${userCars.length}");

    notifyListeners();
  }

  setisUserCarsLoaded(bool isUserCarsLoaded) {
    this.isUserCarsLoaded = isUserCarsLoaded;
    notifyListeners();
  }

  onSelectAcar(String value) {
    initValueForSelectACar = value;
    notifyListeners();
  }

  setImageSeletedOrNot(bool value) {
    isImageSelected = value;
    notifyListeners();
  }

  setSelectedImage(PickedFile file) {
    imageList.add(file);
    notifyListeners();
  }

  String getImage(int index) {
    PickedFile file = imageList[index];
    return file.path;
  }

  setFreeComment(String freeComment) {
    this.freeComment = freeComment;
    // notifyListeners();
  }

  submitOrder(BuildContext context, int screenNumber, bool isFromDicountOffers,
      int offerID) {
    List<int> issueTypes = [];
    if (screenNumber == 1) {

      issueTypes=selectedIssuesList;
    }
    if (screenNumber == 0) {
      if (initValueForSelectACar == "Select a car".tr ||
          address == "Select Location".tr) {
        Get.snackbar("Incomplete information".tr,
            "Please find and correct which is missing".tr);
        return;
      }
    }
    else {
      if (initValueForSelectACar == "Select a car".tr ||
          issueTypes.length == 0 ||
          address == "Select Location".tr) {
        logger.e(address);

        Get.snackbar("Incomplete information".tr,
            "Please find and correct which is missing".tr);
        return;
      }
    }






    if (freeComment.isEmpty) {
      Get.snackbar( "Invalid Details".tr,"you have to add a comment to let the workshop catch your issue easily.".tr);
      return;
    }
    Get.dialog(Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: true);
    // String carInformationId = "0";
    // for (int i = 0;
    //     i < carInformationReponseFromJsonByUserID.result.length;
    //     i++) {
    //   if (carInformationReponseFromJsonByUserID.result[i].carName ==
    //       initValueForSelectACar) {
    //     carInformationId = carInformationReponseFromJsonByUserID
    //         .result[i].carInformationId
    //         .toString();
    //   }
    // }
    SharedPreferences.getInstance().then((value) {
      Map<String, String> body;
      Map<String, String> identifier = {};

      if (!isFromDicountOffers) {
        body = {
          'AddressLocation': '$address',
          'Longitude': '$longitude',
          'Latitude': '$latitude',
          'UserId': '${value.getString(Finals.USER_ID)}',
          'CarInformationId': '${carInformationReponseFromJsonByUserID.result[selectedCarIndex].carInformationId}',
          'Comment': '$freeComment'
        };

        for (int i = 0; i < issueTypes.length; i++) {
          identifier["IssueType[$i]"] = issueTypes[i].toString();
        }
      }
      else {
        body = {
          'addressLocation': '$address',
          'longitude': '$longitude',
          'latitude': '$latitude',
          'discountOfferId': '$offerID',
          'userId': '${value.getString(Finals.USER_ID)}',
          'carInformationId': '${carInformationReponseFromJsonByUserID.result[selectedCarIndex].carInformationId}',
          'comment': '$freeComment'
        };
        for (int i = 0; i < issueTypes.length; i++) {
          identifier["issueType[$i]"] = issueTypes[i].toString();
        }
      }

      body.addAll(identifier);

      logger.w(body);
      print(carInformationReponseFromJsonByUserID.result[selectedCarIndex].carInformationId);
      print(carInformationReponseFromJsonByUserID.result[selectedCarIndex].carName);
      print(selectedCarIndex);

      ApiServices.submitOrder(context, body, screenNumber, imageList, isFromDicountOffers);
    });
  }

  setissuetypesList(List<int> issuetypesList) {
    this.selectedIssuesList = issuetypesList;
    notifyListeners();
  }

  void removeImage(int index) {
    imageList.removeAt(index);
    notifyListeners();
  }
  int screenChecked;
  int offerID;
  bool isFromDicountOffers=false;
  void setOrderTyepe(int screenChecked, int offerID, bool isFromDicountOffers) {
    this.screenChecked=screenChecked;
    this.offerID=offerID;
    this.isFromDicountOffers=isFromDicountOffers;
  }
}
