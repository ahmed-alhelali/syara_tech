import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/profile/backend/api_profile_service.dart';

final profileFetcherProvider = Provider<ApiProfileService>((ref) => ApiProfileService());
