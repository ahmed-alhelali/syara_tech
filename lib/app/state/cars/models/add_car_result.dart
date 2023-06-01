import 'package:sayara_tech_app/app/state/cars/models/car.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';

class AddCarResult {
  final int? carId;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  AddCarResult({
    required this.carId,
    this.requestStatus,
    this.errorMessage,
  });

  factory AddCarResult.success(int carId) {
    return AddCarResult(
      carId: carId,
      requestStatus: RequestStatus.success,
    );
  }

  factory AddCarResult.failure(String errorMessage) {
    return AddCarResult(
      carId: null,
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
