import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as devtools;

class ProvidersServices {
  static void refreshAutoDisposeFutureProvider({
    required WidgetRef ref,
    required AutoDisposeFutureProvider provider,
    required String providerName,
    required String fromPage,
  }) {
    var refresh = ref.refresh(provider);
    refresh.whenData(
      (value) => devtools.log("$fromPage $providerName has been refreshed"),
    );
  }


  static void refreshFutureProvider({
    required WidgetRef ref,
    required FutureProvider provider,
    required String providerName,
    required String fromPage,
  }) {
    var refresh = ref.refresh(provider);
    refresh.whenData(
          (value) => devtools.log("$fromPage $providerName has been refreshed"),
    );
  }
}
