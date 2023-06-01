import 'package:sayara_tech_app/app/state/models/request_status.dart';

class LoginStep1Result {
  final int? step2Id;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  LoginStep1Result({
    this.step2Id,
    this.requestStatus,
    this.errorMessage,
  });

  factory LoginStep1Result.success(int step2Id) {
    return LoginStep1Result(
      step2Id: step2Id,
      requestStatus: RequestStatus.success,
    );
  }

  factory LoginStep1Result.failure(String errorMessage) {
    return LoginStep1Result(
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
