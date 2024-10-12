import 'package:recruitment_test_website/core/services/local_storage/app_store.dart';
import 'package:recruitment_test_website/core/services/local_storage/app_store_imp.dart';

class CacheService {
  CacheService._internal();

  static final AppStorageI _appStorage = AppStorageImp();

  static AppStorageI get instance {
    return _appStorage;
  }
}
