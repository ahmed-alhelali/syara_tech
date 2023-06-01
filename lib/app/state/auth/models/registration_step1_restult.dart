import 'package:sayara_tech_app/app/state/models/request_status.dart';

class RegistrationStep1Result {
  final int? step2Id;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  RegistrationStep1Result({
    this.step2Id,
    this.requestStatus,
    this.errorMessage,
  });

  factory RegistrationStep1Result.success(int step2Id) {
    return RegistrationStep1Result(
      step2Id: step2Id,
      requestStatus: RequestStatus.success,
    );
  }

  factory RegistrationStep1Result.failure(String errorMessage) {
    return RegistrationStep1Result(
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
