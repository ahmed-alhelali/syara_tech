import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

//TODO if this class is the same registrationStep2Resulat then
//TODO merge the both under named AuthStep2Result
class LoginStep2Result {
  final UserToken? userToken;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  LoginStep2Result({
    this.userToken,
    this.requestStatus,
    this.errorMessage,
  });

  factory LoginStep2Result.success(UserToken userToken) {
    return LoginStep2Result(
      userToken: userToken,
      requestStatus: RequestStatus.success,
    );
  }

  factory LoginStep2Result.failure(String errorMessage) {
    return LoginStep2Result(
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
