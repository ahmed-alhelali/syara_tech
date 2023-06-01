import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/models_notifier.dart';


final modelsNotifierProvider =
StateNotifierProvider<ModelsNotifier, List<Map<String,dynamic>>>((ref) => ModelsNotifier());
