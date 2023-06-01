import 'dart:collection';
import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';

class RegistrationStep2Payload extends MapView<String, dynamic> {
  RegistrationStep2Payload({
    int? step1Id,
    String? smsCode,
  }) : super(
          {
            ApiFieldName.step1Id: step1Id,
            ApiFieldName.smsCode: smsCode,
          },
        );
}
