import 'dart:collection';

import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';

class LoginStep1Payload extends MapView<String, dynamic> {
  LoginStep1Payload({
    String? mobileNo,
  }) : super(
          {
            ApiFieldName.mobileNo: mobileNo,
          },
        );
}
