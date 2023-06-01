import 'package:sayara_tech_app/app/state/cars/models/car.dart';
import 'package:sayara_tech_app/app/state/models/request_status.dart';
import 'package:sayara_tech_app/app/state/profile/models/profile.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class FetchCarsResult {
  final List<Car>? cars;
  final RequestStatus? requestStatus;
  final String? errorMessage;

  FetchCarsResult({
    required this.cars,
    this.requestStatus,
    this.errorMessage,
  });

  factory FetchCarsResult.success(List<Car> cars) {
    return FetchCarsResult(
      cars: cars,
      requestStatus: RequestStatus.success,
    );
  }

  factory FetchCarsResult.failure(String errorMessage) {
    return FetchCarsResult(
      cars: null,
      errorMessage: errorMessage,
      requestStatus: RequestStatus.failure,
    );
  }
}
