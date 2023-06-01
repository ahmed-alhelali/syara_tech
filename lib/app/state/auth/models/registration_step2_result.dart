import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class RegistrationStep2Result {
  final UserToken? userToken;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  RegistrationStep2Result({
    this.userToken,
    this.requestStatus,
    this.errorMessage,
  });

  factory RegistrationStep2Result.success(UserToken userToken) {
    return RegistrationStep2Result(
      userToken: userToken,
      requestStatus: RequestStatus.success,
    );
  }

  factory RegistrationStep2Result.failure(String errorMessage) {
    return RegistrationStep2Result(
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
