
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarModelsNotifier extends StateNotifier<int> {
  CarModelsNotifier() : super(0);

  void changeTheModels({required int id}) {
    state = id;
  }

  int get model => state;
}