import 'dart:developer' as devtools;
import 'package:dio/dio.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/backend_services/dio_service.dart';
import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';
import 'package:sayara_tech_app/app/state/constants/end_points_urls.dart';
import 'package:sayara_tech_app/app/state/constants/error_response_messages.dart';
import 'package:sayara_tech_app/app/state/constants/request_headers.dart';
import 'package:sayara_tech_app/app/state/auth/models/login_step1_result.dart';
import 'package:sayara_tech_app/app/state/auth/models/login_step2_result.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step2_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/registration_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/registration_step2_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/registration_step1_restult.dart';
import 'package:sayara_tech_app/app/state/auth/models/registration_step2_result.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class Authenticator {
  Future<RegistrationStep1Result> registrationStep1(
      {required RegistrationStep1Payload step1payload}) async {
    try {
      EndPointUrl registrationStep1EndPoint =
          EndPointsUrls.registrationStep1EndPoint;

      var response = await DioService.dio.post(
        registrationStep1EndPoint,
        data: step1payload,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools
            .log("${ConstantsLog.registrationResponseStep1} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final step1Id =
              response.data[ApiFieldName.data][ApiFieldName.step2Id];
          return RegistrationStep1Result.success(step1Id);
        } else {
          final message = response.data[ApiFieldName.message];
          String errorMessage;
          switch (message) {
            case ErrorResponseMessages.mobileNumberIsAlreadyInUse:
              errorMessage = "Mobile number is Already used";
              break;
            case ErrorResponseMessages.emailIsAlreadyInUse:
              errorMessage = "Email is Already used";
              break;
            default:
              errorMessage = "Something went to wrong";
          }
          devtools
              .log("${ConstantsLog.registrationResponseStep1} $errorMessage");
          return RegistrationStep1Result.failure(errorMessage);
        }
      } else {
        devtools.log(
            "${ConstantsLog.errorFromRegistrationStep1} ${response.statusCode}: ${response.statusMessage}");

        return RegistrationStep1Result.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (e) {
      devtools.log(
          "${ConstantsLog.errorFromRegistrationStep1} The entire request fills");
    }
    return RegistrationStep1Result.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<RegistrationStep2Result> registrationStep2(
      {required RegistrationStep2Payload step2payload}) async {
    try {
      EndPointUrl registrationStep2EndPoint =
          EndPointsUrls.registrationStep2EndPoint;

      final step1Id = step2payload[ApiFieldName.step1Id];
      final smsCode = step2payload[ApiFieldName.smsCode];
      String requestEndpoint =
          ("$registrationStep2EndPoint?step1id=$step1Id&smscode=$smsCode");
      var response = await DioService.dio.post(
        requestEndpoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools
            .log("${ConstantsLog.registrationResponseStep2} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final userToken = response.data[ApiFieldName.data];
          return RegistrationStep2Result.success(userToken.toString());
        } else {
          final errorMessage = response.data[ApiFieldName.message];
          devtools.log("${ConstantsLog.errorFromRegistrationStep2} $errorMessage");
          return RegistrationStep2Result.failure(errorMessage);
        }
      } else {
        devtools.log(
            "${ConstantsLog.errorFromRegistrationStep2} ${response.statusCode}: ${response.statusMessage}");
        return RegistrationStep2Result.failure(
            ErrorResponseMessages.tryAgainError);
      }
    } catch (e) {
      devtools.log(
          "${ConstantsLog.errorFromRegistrationStep2} The entire request fills");
    }
    return RegistrationStep2Result.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<LoginStep1Result> loginStep1({
    required LoginStep1Payload step1payload,
  }) async {
    try {
      EndPointUrl loginStep1EndPoint = EndPointsUrls.loginStep1EndPoint;

      final mobileNo = step1payload[ApiFieldName.mobileNo];
      String requestEndpoint = ("$loginStep1EndPoint?mobileno=$mobileNo");

      var response = await DioService.dio.post(
        requestEndpoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.loginResponseStep1} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final step1Id =
              response.data[ApiFieldName.data][ApiFieldName.step2Id];
          return LoginStep1Result.success(step1Id);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools.log("${ConstantsLog.errorFromLoginStep1} $errorMessage");
          return LoginStep1Result.failure(errorMessage);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log(
            "${ConstantsLog.errorFromLoginStep1} ${response.statusCode}: ${response.statusMessage}");
        return LoginStep1Result.failure(error);
      }
    } catch (e) {
      devtools.log("${ConstantsLog.errorFromLoginStep1} The entire request fills");
    }
    return LoginStep1Result.failure(ErrorResponseMessages.tryAgainError);
  }

  Future<LoginStep2Result> loginStep2({
    required LoginStep2Payload step2payload,
  }) async {
    try {
      EndPointUrl loginStep2EndPoint = EndPointsUrls.loginStep2EndPoint;

      final mobileNo = step2payload[ApiFieldName.mobileNo];
      final step1Id = step2payload[ApiFieldName.step1Id];
      final smsCode = step2payload[ApiFieldName.smsCode];
      String requestEndpoint =
          ("$loginStep2EndPoint?mobileno=$mobileNo&step1id=$step1Id&smscode=$smsCode");

      var response = await DioService.dio.post(
        requestEndpoint,
        options: Options(
          headers: RequestHeaders.enLanguageHeader,
        ),
      );

      if (response.statusCode == 200) {
        devtools.log("${ConstantsLog.loginResponseStep2} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final userToken = response.data[ApiFieldName.data];
          return LoginStep2Result.success(userToken.toString());
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools.log("${ConstantsLog.errorFromLoginStep2} $errorMessage");
          return LoginStep2Result.failure(errorMessage);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromLoginStep2} $error");
        return LoginStep2Result.failure(error);
      }
    } catch (error) {
      devtools.log("${ConstantsLog.errorFromLoginStep2} The entire request fills : error => $error");
    }
    return LoginStep2Result.failure(ErrorResponseMessages.tryAgainError);
  }
}
