import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/car_model_notifier.dart';


final carModelIdNotifierProvider =
StateNotifierProvider<CarModelsNotifier, int>((ref) => CarModelsNotifier());

