import 'package:flutter/cupertino.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';

class MyCarsScreenProvider extends ChangeNotifier{
  bool isMyCarLoaded=false;
  GetMyCarsByUserId getMyCarsByUserIdFromJson;

  setMyCars(bool isMyCarLoaded, GetMyCarsByUserId getMyCarsByUserIdFromJson){
    this.isMyCarLoaded= isMyCarLoaded;
    this.getMyCarsByUserIdFromJson=getMyCarsByUserIdFromJson;
    notifyListeners();
  }




}