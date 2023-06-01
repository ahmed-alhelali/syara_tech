import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fetch_car_detail_result.dart';
import 'car_fetcher_provider.dart';

final fetchModelsProvider = FutureProvider<FetchCarDetailResult>(
  (ref) async {
    FetchCarDetailResult result =
        await ref.watch(carFetcherProvider).fetchModels();

    return result;
  },
);
