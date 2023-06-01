import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void changeTheLoadingStatus({required bool isLoading}) {
    state = isLoading;
  }

  bool get isLoading => state;
}
