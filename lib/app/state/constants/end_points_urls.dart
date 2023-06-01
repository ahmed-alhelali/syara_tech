import 'package:sayara_tech_app/app/state/constants/api_endpoints_urls.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class EndPointsUrls {
  static EndPointUrl registrationStep1EndPoint =
      (ApiConstants.baseUrl + ApiConstants.registrationStep1);

  static EndPointUrl registrationStep2EndPoint =
      (ApiConstants.baseUrl + ApiConstants.registrationStep2);

  static EndPointUrl loginStep1EndPoint =
      (ApiConstants.baseUrl + ApiConstants.loginStep1);

  static EndPointUrl loginStep2EndPoint =
      (ApiConstants.baseUrl + ApiConstants.loginStep2);

  static EndPointUrl getProfileEndPoint =
      (ApiConstants.baseUrl + ApiConstants.profile);

  static EndPointUrl getCarsEndPoint =
      (ApiConstants.baseUrl + ApiConstants.carsList);

  static EndPointUrl addCarEndPoint =
      (ApiConstants.baseUrl + ApiConstants.addCar);

  static EndPointUrl getVendorsEndPoint =
      (ApiConstants.baseUrl + ApiConstants.vendors);

  static EndPointUrl getModelsEndPoint =
      (ApiConstants.baseUrl + ApiConstants.models);

  static EndPointUrl getSingleModelEndPoint =
      (ApiConstants.baseUrl + ApiConstants.models);
  static EndPointUrl getColorsEndPoint =
      (ApiConstants.baseUrl + ApiConstants.colors);


  static EndPointUrl getFuelsEndPoint =
      (ApiConstants.baseUrl + ApiConstants.fuel);

  static EndPointUrl getCylinderByIdEndPoint =
      (ApiConstants.baseUrl + ApiConstants.cylinder);
}
