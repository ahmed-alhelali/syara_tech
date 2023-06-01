import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayara_tech_app/app/notifiers/vendor_notifier.dart';

final vendorNotifierProvider =
StateNotifierProvider<VendorNotifier, int>((ref) => VendorNotifier());




