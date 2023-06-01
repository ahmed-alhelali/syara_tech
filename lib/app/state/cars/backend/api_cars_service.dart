import 'package:dio/dio.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/backend_services/dio_service.dart';
import 'package:sayara_tech_app/app/state/cars/models/add_car_result.dart';
import 'package:sayara_tech_app/app/state/cars/models/car.dart';
import 'package:sayara_tech_app/app/state/cars/models/fetch_cars_result.dart';
import 'package:sayara_tech_app/app/state/cars/models/fetch_car_detail_result.dart';
import 'package:sayara_tech_app/app/state/cars/models/payloads/add_car_payload.dart';
import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';
import 'package:sayara_tech_app/app/state/constants/end_points_urls.dart';
import 'package:sayara_tech_app/app/state/constants/error_response_messages.dart';
import 'package:sayara_tech_app/app/state/constants/request_headers.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';
import 'dart:developer' as devtools;

class ApiCarsService {
  Future<FetchCarsResult> fetchCars({required UserToken userToken}) async {
    try {
      EndPointUrl carsEndPoint = EndPointsUrls.getCarsEndPoint;

      var response = await DioService.dio.post(
        carsEndPoint,
        options: Options(
          headers: RequestHeaders.authorizationHeader(
            userToken: userToken,
          ),
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.fetchingCarsResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Car> cars = [];
          for (var c in result) {
            Car car = Car.fromJson(c);
            cars.add(car);
          }

          return FetchCarsResult.success(cars);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools
              .log("${ConstantsLog.errorFromCarsListFetching} $errorMessage");
          return FetchCarsResult.failure(errorMessage);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromCarsListFetching} $error");
        return FetchCarsResult.failure(ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromCarsListFetching} The entire request fills : error => $error");
    }
    return FetchCarsResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<FetchCarDetailResult> fetchVendors() async {
    EndPointUrl vendorsEndPoint = EndPointsUrls.getVendorsEndPoint;

    try {
      var response = await DioService.dio.get(
        vendorsEndPoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools
            .log("${ConstantsLog.fetchingVendorsResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Map<String, dynamic>> vendors = [];
          for (var c in result) {
            vendors.add(c);
          }

          return FetchCarDetailResult.success(vendors);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools.log(
              "${ConstantsLog.errorFromVendorsListFetching} $errorMessage");
          return FetchCarDetailResult.failure(
              ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromVendorsListFetching} $error");
        return FetchCarDetailResult.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromVendorsListFetching} The entire request fills : error => $error");
    }
    return FetchCarDetailResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<FetchCarDetailResult> fetchModels() async {
    EndPointUrl modelsEndPoint = EndPointsUrls.getModelsEndPoint;

    try {
      var response = await DioService.dio.get(
        modelsEndPoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.fetchingModelsResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Map<String, dynamic>> models = [];
          for (var c in result) {
            models.add(c);
          }

          return FetchCarDetailResult.success(models);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools
              .log("${ConstantsLog.errorFromModelsListFetching} $errorMessage");
          return FetchCarDetailResult.failure(
              ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromModelsListFetching} $error");
        return FetchCarDetailResult.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromModelsListFetching} The entire request fills : error => $error");
    }
    return FetchCarDetailResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<FetchCarDetailResult> fetchColors() async {
    EndPointUrl colorsEndPoint = EndPointsUrls.getColorsEndPoint;

    try {
      var response = await DioService.dio.get(
        colorsEndPoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.fetchingColorsResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Map<String, dynamic>> colors = [];
          for (var c in result) {
            colors.add(c);
          }

          return FetchCarDetailResult.success(colors);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools
              .log("${ConstantsLog.errorFromColorsListFetching} $errorMessage");
          return FetchCarDetailResult.failure(
              ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromColorsListFetching} $error");
        return FetchCarDetailResult.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromColorsListFetching} The entire request fills : error => $error");
    }
    return FetchCarDetailResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<FetchCarDetailResult> fetchFuels() async {
    EndPointUrl fuelsEndPoint = EndPointsUrls.getFuelsEndPoint;

    try {
      var response = await DioService.dio.get(
        fuelsEndPoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.fetchingFuelsResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Map<String, dynamic>> fuelsTypes = [];
          for (var c in result) {
            fuelsTypes.add(c);
          }

          return FetchCarDetailResult.success(fuelsTypes);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools
              .log("${ConstantsLog.errorFromFuelsListFetching} $errorMessage");
          return FetchCarDetailResult.failure(
              ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromFuelsListFetching} $error");
        return FetchCarDetailResult.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromFuelsListFetching} The entire request fills : error => $error");
    }
    return FetchCarDetailResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<FetchCarDetailResult> fetchCylinders({required int carId}) async {
    EndPointUrl modelsEndPoint = EndPointsUrls.getCylinderByIdEndPoint;

    try {
      var response = await DioService.dio.get(
        "$modelsEndPoint/$carId",
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools
            .log("${ConstantsLog.fetchingCylindersResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          List<Map<String, dynamic>> fuelsTypes = [];
          for (var c in result) {
            fuelsTypes.add(c);
          }

          return FetchCarDetailResult.success(fuelsTypes);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools.log(
              "${ConstantsLog.errorFromCylindersListFetching} $errorMessage");
          return FetchCarDetailResult.failure(
              ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromCylindersListFetching} $error");
        return FetchCarDetailResult.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromCylindersListFetching} The entire request fills : error => $error");
    }
    return FetchCarDetailResult.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<AddCarResult> addCar(
      {required UserToken userToken, required AddCarPayload carPayload}) async {
    try {
      EndPointUrl addCarEndPoint = EndPointsUrls.addCarEndPoint;

      var response = await DioService.dio.post(
        addCarEndPoint,
        data: carPayload,
        options: Options(
          headers: RequestHeaders.authorizationHeader(
            userToken: userToken,
          ),
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.addCarResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final carId = response.data[ApiFieldName.data];
          return AddCarResult.success(carId);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools.log("${ConstantsLog.errorFromLoginStep2} $errorMessage");
          return AddCarResult.failure(errorMessage);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromAddingCar} $error");
        return AddCarResult.failure(error);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromAddingCar} The entire request fills : error => $error");
    }
    return AddCarResult.failure(ErrorResponseMessages.tryAgainError);
  }
}
