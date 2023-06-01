import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/user_token_notifier.dart';
import 'package:sayara_tech_app/app/state/cars/models/payloads/add_car_payload.dart';
import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

final userTokenNotifierProvider =
StateNotifierProvider<UserTokenNotifier, UserToken?>(
      (ref) => UserTokenNotifier(),
);



final carPayloadNotifierProvider =
StateNotifierProvider<CarPayloadNotifier, AddCarPayload?>(
      (ref) => CarPayloadNotifier(),
);
