import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/constants/constants_log.dart';
import 'package:sayara_tech_app/app/state/profile/models/fetch_profile_result.dart';
import 'package:sayara_tech_app/app/state/profile/providers/profile_fetcher_provider.dart';
import 'package:sayara_tech_app/app/state/providers/user_token_provider.dart';
import 'dart:developer' as devtools;

final fetchProfileProvider = FutureProvider.autoDispose<FetchProfileResult>(
  (ref) async {
    final userToken = ref.read(userTokenNotifierProvider.notifier).userToken;

    if (userToken!.isNotEmpty) {
      FetchProfileResult result =
          await ref.watch(profileFetcherProvider).fetchProfile(userToken: userToken);
      return result;
    } else {
      devtools.log(
          "${ConstantsLog.fromProfileProvider} The request fail because the userToken is empty");
      return FetchProfileResult.failure("Something went to wrong");
    }
  },
);
