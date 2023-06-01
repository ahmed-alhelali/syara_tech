import 'package:sayara_tech_app/app/state/cars/models/car.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';

class FetchCarDetailResult {
  final List<Map<String, dynamic>>? detail;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  FetchCarDetailResult({
    required this.detail,
    this.requestStatus,
    this.errorMessage,
  });

  factory FetchCarDetailResult.success(List<Map<String,dynamic>> detail) {
    return FetchCarDetailResult(
      detail: detail,
      requestStatus: RequestStatus.success,
    );
  }

  factory FetchCarDetailResult.failure(String errorMessage) {
    return FetchCarDetailResult(
      detail: null,
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
