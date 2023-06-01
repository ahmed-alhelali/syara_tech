import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/loading_notifier.dart';

final loadingNotifierProvider =
    StateNotifierProvider<LoadingNotifier, bool>((ref) => LoadingNotifier());

