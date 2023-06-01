import 'dart:collection';

import 'package:sayara_tech_app/app/state/constants/api_fields_name.dart';

class RegistrationStep1Payload extends MapView<String, dynamic> {
  RegistrationStep1Payload({
    String? name,
    String? pwd,
    String? email,
    String? mobile,
  }) : super(
          {
            ApiFieldName.name: name,
            ApiFieldName.pwd: pwd,
            ApiFieldName.email: email,
            ApiFieldName.mobile: mobile,
          },
        );
}
