import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/state/auth/backend/authenticator.dart';


final authenticatorProvider = Provider<Authenticator>((ref) => Authenticator());
