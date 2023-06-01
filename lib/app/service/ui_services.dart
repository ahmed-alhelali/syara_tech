import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sayara_tech_app/app/constants/constants_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UIServices {
  static final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  static final registrationPhoneRegex = RegExp(r'^\d{9}$');
  static final loginPhoneRegex = RegExp(r'^966\d{9}$');

  static bool emailIsMatched(String email) {
    return emailRegex.hasMatch(email);
  }

  static bool phoneNumberIsMatchedInRegistrationCase(String phone) {
    return registrationPhoneRegex.hasMatch(phone);
  }

  static bool phoneNumberIsMatchedInLoginCase(String phone) {
    return loginPhoneRegex.hasMatch(phone);
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static void unFocusAll(List<FocusNode> nodes) {
    for (var node in nodes) {
      node.unfocus();
    }
  }

  static showSnackBar({
    required BuildContext context,
    required Icon icon,
    required Text text,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.zero,
        content: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                icon,
                const Gap(8),
                text,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static Future<void> setUserTokenLocally({required String userToken}) async {
    final shared = await SharedPreferences.getInstance();

    shared.setString(ConstantsKeys.userTokenKey, userToken);
  }

  static Future<void> removeUserTokenLocally() async {
    final shared = await SharedPreferences.getInstance();

    shared.remove(ConstantsKeys.userTokenKey);
  }

  static Future<String?> getUserTokenFromLocal() async {
    final shared = await SharedPreferences.getInstance();

    String? userToken = shared.getString(ConstantsKeys.userTokenKey);

    return userToken;
  }

  static String formatTheDate(String dateAsString) {
    return DateFormat.yMMMd().format(
      DateTime.tryParse(
        dateAsString,
      ) as DateTime,
    );
  }
}
