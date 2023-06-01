import 'package:flutter_riverpod/flutter_riverpod.dart';

final step2IdProvider = StateProvider<int>((ref) => 0);

final otpProvider = StateProvider<String>((ref) => "");
final mobileNoProvider = StateProvider<String>((ref) => "");
