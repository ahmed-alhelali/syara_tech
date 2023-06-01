import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/auth/models/registration_step1_restult.dart';
import 'package:sayara_tech_app/app/state/auth/models/registration_step2_result.dart';
import 'package:sayara_tech_app/app/state/auth/providers/authenticator_provider.dart';
import 'package:sayara_tech_app/app/state/auth/providers/payload_providers.dart';

final registrationStep1Provider =
    FutureProvider.autoDispose<RegistrationStep1Result>((ref) async {
  final step1Payload = ref.read(registrationStep1PayloadProvider);

  return ref
      .watch(authenticatorProvider)
      .registrationStep1(step1payload: step1Payload);
});

final registrationStep2Provider =
    FutureProvider.autoDispose<RegistrationStep2Result>((ref) async {
  final step2Payload = ref.watch(registrationStep2PayloadProvider);

  return ref
      .watch(authenticatorProvider)
      .registrationStep2(step2payload: step2Payload);
});

