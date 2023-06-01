import 'package:dio/dio.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/backend_services/dio_service.dart';
import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';
import 'package:sayara_tech_app/app/state/constants/end_points_urls.dart';
import 'package:sayara_tech_app/app/state/constants/error_response_messages.dart';
import 'package:sayara_tech_app/app/state/constants/request_headers.dart';
import 'package:sayara_tech_app/app/state/profile/models/fetch_profile_result.dart';
import 'package:sayara_tech_app/app/state/profile/models/profile.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';
import 'dart:developer' as devtools;

class ApiProfileService {
  Future<FetchProfileResult> fetchProfile(
      {required UserToken userToken}) async {
    try {
      EndPointUrl profileEndPoint = EndPointsUrls.getProfileEndPoint;

      var response = await DioService.dio.post(
        profileEndPoint,
        options: Options(
          headers: RequestHeaders.authorizationHeader(
            userToken: userToken,
          ),
        ),
      );

      if (response.statusCode == 200) {
        devtools
            .log("${ConstantsLog.fetchingProfileResponse} ${response.data}");
        if (response.data[ApiFieldName.status] == true) {
          final result = response.data[ApiFieldName.data];

          Profile profile = Profile.fromJson(result);

          return FetchProfileResult.success(profile);
        } else {
          final errorMessage = response.data[ApiFieldName.error];
          devtools
              .log("${ConstantsLog.errorFromProfileFetching} $errorMessage");
          return FetchProfileResult.failure(ErrorResponseMessages.tryAgainError);
        }
      } else {
        final error = "Error ${response.statusCode}: ${response.statusMessage}";
        devtools.log("${ConstantsLog.errorFromProfileFetching} $error");
        return FetchProfileResult.failure(ErrorResponseMessages.tryAgainError);
      }
    } catch (error) {
      devtools.log(
          "${ConstantsLog.errorFromProfileFetching} The entire request fills : error => $error");
    }
    return FetchProfileResult.failure(ErrorResponseMessages.tryAgainError);
  }
}
