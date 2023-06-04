import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/providers/internet_connection_provider.dart';
import 'package:sayara_tech_app/app/service/ui_services.dart';
import 'package:sayara_tech_app/app/widgets/snack_bar_widgets.dart';
import 'package:sayara_tech_app/config/config.dart';
import 'package:sayara_tech_app/app/pages/logged_in_pages/navigation_bar_page.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'package:sayara_tech_app/app/theme/sayara_tech_theme.dart';
import 'package:sayara_tech_app/app/pages/unlogged_in_pages/registration_page.dart';
import 'dart:developer' as devtools;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userToken = await AppConfig.initUserToken();
  runApp(
    ProviderScope(
      child: SayaraTechApp(
        userToken: userToken,
      ),
    ),
  );
}

class SayaraTechApp extends ConsumerWidget {
  dynamic userToken;

  SayaraTechApp({super.key, required this.userToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool userLoggedIn = userToken != null;
    Future.delayed(const Duration(milliseconds: 200), () {
      if (userLoggedIn == true && userToken.isNotEmpty) {
        ref
            .watch(userTokenNotifierProvider.notifier)
            .updateTheUserToken(userToken: userToken);
      }
    });
    return MaterialApp(
      title: 'SayaraTech App',
      debugShowCheckedModeBanner: false,
      theme: SayaraTechTheme.appTheme,
      home: userLoggedIn ? const NavigationBarPage() : RegistrationPage(),
    );
  }
}
