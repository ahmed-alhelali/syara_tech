 import 'package:sayara_tech_app/app/state/typedefs/typedefs.dart';

class RequestHeaders {
  static final enLanguageHeader = {
    "lng": "en",
  };

  static Map<String, String> authorizationHeader(
      {required UserToken userToken}) {
    return {
      "Authorization": userToken,
      "lng": "en",
    };
  }
}
