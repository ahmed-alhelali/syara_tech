import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/login_step2_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/registration_step1_payload.dart';
import 'package:sayara_tech_app/app/state/auth/models/payloads/registration_step2_payload.dart';

final registrationStep1PayloadProvider =
    StateProvider<RegistrationStep1Payload>(
        (ref) => RegistrationStep1Payload());

final registrationStep2PayloadProvider =
    StateProvider<RegistrationStep2Payload>(
        (ref) => RegistrationStep2Payload());

final loginStep1PayloadProvider =
    StateProvider<LoginStep1Payload>((ref) => LoginStep1Payload());

final loginStep2PayloadProvider =
    StateProvider<LoginStep2Payload>((ref) => LoginStep2Payload());
