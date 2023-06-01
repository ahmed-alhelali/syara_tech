import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/profile/models/profile.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';


class FetchProfileResult {
  final Profile? profile;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  FetchProfileResult({
    required this.profile,
    this.requestStatus,
    this.errorMessage,
  });

  factory FetchProfileResult.success(Profile profile) {
    return FetchProfileResult(
      profile: profile,
      requestStatus: RequestStatus.success,
    );
  }

  factory FetchProfileResult.failure(String errorMessage) {
    return FetchProfileResult(
      profile: null,
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
