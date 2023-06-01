import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/notifiers/user_token_notifier.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'dart:developer' as devtools;

class AppConfig {
  static Future<String?> initUserToken() async {
    String? userToken = await UIServices.getUserTokenFromLocal();

    if (userToken != null) {
      UserTokenNotifier userTokenNotifier = UserTokenNotifier();
      userTokenNotifier.updateTheUserToken(userToken: userToken);

      devtools.log(
          "${ConstantsLog.fromAppConfig} Current user's token: ${userTokenNotifier.userToken}");
      return userTokenNotifier.userToken;
    } else {
      devtools.log(
          "${ConstantsLog.fromAppConfig} There is no current user logged in");
    }
    return null;
  }
}
