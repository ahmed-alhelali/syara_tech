import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/providers/car_model_notifier_provider.dart';
import 'package:sayara_tech_app/app/state/cars/models/fetch_car_detail_result.dart';
import 'package:sayara_tech_app/app/state/cars/providers/car_fetcher_provider.dart';

final fetchCarClyinderProvider = FutureProvider<FetchCarDetailResult>(
  (ref) async {
    final carModelId = ref.read(carModelIdNotifierProvider.notifier).model;

    FetchCarDetailResult result =
        await ref.watch(carFetcherProvider).fetchCylinders(carId: carModelId);

    return result;
  },
);
