import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObscureNotifier extends StateNotifier<bool> {
  ObscureNotifier() : super(true);

  void changeTheObscureStatus() {
    state = !state;
  }

  bool get stateOfVisibility => state;
}
