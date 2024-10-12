import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/utils/loggers/logger.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Log.info(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    Log.info(
      '''
{  
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "DISPOSED"
}''',
    );
  }
}
