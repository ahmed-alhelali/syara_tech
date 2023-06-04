import 'dart:developer' as devtools;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';

final internetConnectionProvider = Provider<InternetConnectionChecker>((ref) {
  return InternetConnectionChecker();
});

final internetConnectionStatusProvider =
    StreamProvider.autoDispose<bool>((ref) {
  final internetConnectionChecker = ref.watch(internetConnectionProvider);

  internetConnectionChecker.onStatusChange.listen((status) {
    devtools.log(
      "${ConstantsLog.internetConnection} internet connection status is: ${status == InternetConnectionStatus.connected ? "connect" : "disconnected"}",
    );
  });

  return internetConnectionChecker.onStatusChange.map((status) {
    return status == InternetConnectionStatus.connected;
  });
});
