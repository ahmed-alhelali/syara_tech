import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/state/cars/models/payloads/add_car_payload.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class UserTokenNotifier extends StateNotifier<UserToken?> {
  UserTokenNotifier() : super(null);

  void updateTheUserToken({required String? userToken}) {
    state = userToken;
    UIServices.setUserTokenLocally(userToken: userToken!);
  }

  void removeTheUserToken(){
    state = null;
    UIServices.removeUserTokenLocally();
  }

  UserToken? get userToken => state;
}

class CarPayloadNotifier extends StateNotifier<AddCarPayload?> {
  CarPayloadNotifier() : super(null);

  void updateTheCarPayload({required AddCarPayload? carPayload}) {
    state = carPayload;

  }



  AddCarPayload? get carPayload => state;
}
