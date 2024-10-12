import 'package:flutter_network/flutter_network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/services/local_storage/cache_service.dart';
import 'package:recruitment_test_website/core/services/network/api_end_points.dart';

final networkProvider = Provider(
  (ref) {
    return FlutterNetwork(
      baseUrl: API.base,
      tokenCallback: () async {
        return CacheService.instance.retrieveBearerToken();
      },
    );
  },
);
