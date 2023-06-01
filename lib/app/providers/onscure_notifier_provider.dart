import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/obscure_notifier.dart';

final passwordVisibilityProvider =
StateNotifierProvider<ObscureNotifier, bool>((ref) => ObscureNotifier());

