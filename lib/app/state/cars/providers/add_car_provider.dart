import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/cars/models/add_car_result.dart';
import 'package:sayara_tech_app/app/state/cars/providers/car_fetcher_provider.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'dart:developer' as devtools;

final addCarProvider = FutureProvider.autoDispose<AddCarResult>(
  (ref) async {
    final userToken = ref.read(userTokenNotifierProvider.notifier).userToken;
    final carPayLoad = ref.read(carPayloadNotifierProvider.notifier).carPayload;

    if (userToken!.isNotEmpty && carPayLoad!.isNotEmpty) {
      AddCarResult result = await ref
          .watch(carFetcherProvider)
          .addCar(userToken: userToken, carPayload: carPayLoad);

      return result;
    } else {
      devtools.log(
          "${ConstantsLog.errorFromAddingCar} The request fail because the userToken OR carPayload is empty");
      return AddCarResult.failure("Something went to wrong");
    }
  },
);
