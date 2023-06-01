String baseUrlPath = 'https://satc.live/api';

class ApiConstants {
  static const String baseUrl = 'https://satc.live/api';
  static const String registrationStep1 = "/General/Customers/NewRegistrationStep1";
  static const String registrationStep2 = "/General/Customers/NewRegistrationStep2";
  static const String loginStep1 = "/Auth/Token/AuthenticateBySMSStep1";
  static const String loginStep2 = "/Auth/Token/AuthenticateBySMSStep2";
  static const String profile = "/Customer/Profile";
  static const String carsList = "/Customer/Cars";
  static const String addCar = "/Customer/AddCar";
  static const String vendors = "/General/Cars/Vendors";
  static const String models = "/General/Cars/Models";
  static const String colors = "/General/Cars/Colors";
  static const String fuel = "/General/Cars/FuelTypes";
  static const String cylinder = "/General/Cars/Models/Cylinder";


}

//registration
// https://satc.live/api/General/Customers/NewRegistrationStep1
// https://satc.live/api/General/Customers/NewRegistrationStep2

//Auth
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_AuthenticateBySMSStep1Async
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_AuthenticateBySMSStep2Async
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_refreshToken
// class SayaraTechAuthEndPoint {
//   late String endPointUrl;
//
//   SayaraTechAuthEndPoint({int? step}) {
//     if (step == 3) {
//       endPointUrl = '$baseUrlPath/AuthTokenAPI/AuthTokenAPI_refreshToken';
//     } else {
//       endPointUrl =
//           '$baseUrlPath/AuthTokenAPI/AuthTokenAPI_AuthenticateBySMSStep${step}Async';
//     }
//   }
// }

//customer
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetProfile
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_AddNewCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_UpdateCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetCarList

// class SayaraTechCustomerEndPoint {
//   late String endPointUrl;
//
//   //GetProfile
//   //AddNewCar
//   //GetCar
//   //UpdateCar
//   //GetCarList
//   SayaraTechCustomerEndPoint({String? parameter}) {
//     endPointUrl =
//     '$baseUrlPath/SayaraTechCustomersAPI/SayaraTechCustomersAPI_$parameter';
//   }
// }

//registration
// https://satc.live/swagger/ui/index#!/GeneralAPI/GeneralAPI_NewRegistrationStep1Async
// https://satc.live/swagger/ui/index#!/GeneralAPI/GeneralAPI_NewRegistrationStep2Async

//Auth
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_AuthenticateBySMSStep1Async
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_AuthenticateBySMSStep2Async
//https://satc.live/swagger/ui/index#!/AuthTokenAPI/AuthTokenAPI_refreshToken

//customer
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetProfile
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_AddNewCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_UpdateCar
//https://satc.live/swagger/ui/index#!/SayaraTechCustomersAPI/SayaraTechCustomersAPI_GetCarList
