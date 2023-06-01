import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/cars/models/fetch_cars_result.dart';
import 'package:sayara_tech_app/app/state/cars/providers/car_fetcher_provider.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'dart:developer' as devtools;


final fetchCarsProvider = FutureProvider.autoDispose<FetchCarsResult>(
  (ref) async {
    final userToken = ref.read(userTokenNotifierProvider.notifier).userToken;

    if (userToken!.isNotEmpty) {
      FetchCarsResult result = await ref
          .watch(carFetcherProvider)
          .fetchCars(userToken: userToken);

      return result;
    } else {
      devtools.log(
          "${ConstantsLog.errorFromCarsListFetching} The request fail because the userToken is empty");
      return FetchCarsResult.failure("Something went to wrong");
    }
  },
);
