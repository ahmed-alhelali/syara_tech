import 'package:flutter_riverpod/flutter_riverpod.dart';
class VendorNotifier extends StateNotifier<int> {
  VendorNotifier() : super(1);

  void changeTheVendorId({required int id}) {
    state = id;
  }

  int get id => state;
}