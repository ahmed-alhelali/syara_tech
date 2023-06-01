import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/auth/models/login_step1_result.dart';
import 'package:sayara_tech_app/app/state/auth/models/login_step2_result.dart';
import 'package:sayara_tech_app/app/state/auth/providers/authenticator_provider.dart';
import 'package:sayara_tech_app/app/state/auth/providers/payload_providers.dart';

final loginStep1Provider =
    FutureProvider.autoDispose<LoginStep1Result>((ref) async {
  final step1Payload = ref.read(loginStep1PayloadProvider);

  return ref
      .watch(authenticatorProvider)
      .loginStep1(step1payload: step1Payload);
});

final loginStep2Provider =
    FutureProvider.autoDispose<LoginStep2Result>((ref) async {
  final step2Payload = ref.read(loginStep2PayloadProvider);

  return ref
      .watch(authenticatorProvider)
      .loginStep2(step2payload: step2Payload);
});
