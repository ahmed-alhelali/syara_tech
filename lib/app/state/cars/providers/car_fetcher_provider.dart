import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/cars/backend/api_cars_service.dart';
import 'package:sayara_tech_app/app/state/profile/backend/api_profile_service.dart';

final carFetcherProvider = Provider<ApiCarsService>((ref) => ApiCarsService());
