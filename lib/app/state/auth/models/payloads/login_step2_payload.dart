import 'dart:collection';

import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';

class LoginStep2Payload extends MapView<String, dynamic> {
  LoginStep2Payload({
    String? mobileNo,
    int? step1Id,
    String? smsCode,
  }) : super(
          {
            ApiFieldName.mobileNo: mobileNo,
            ApiFieldName.step1Id: step1Id,
            ApiFieldName.smsCode: smsCode,
          },
        );
}
