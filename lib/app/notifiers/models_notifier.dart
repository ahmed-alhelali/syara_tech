import 'package:flutter_riverpod/flutter_riverpod.dart';
class ModelsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ModelsNotifier() : super([]);

  void changeTheModels({required List<Map<String, dynamic>> modelsList}) {
    state.clear();

    state = modelsList;
  }

  List<Map<String, dynamic>> get modelsList => state;
}