import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ntracker_flutter_platform_interface.dart';

/// An implementation of [NtrackerFlutterPlatform] that uses method channels.
class MethodChannelNtrackerFlutter extends NtrackerFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ntracker_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> initialize(String siteId, {bool debug = false}) async {
    await methodChannel.invokeMethod('initialize', {'siteId': siteId, 'debug': debug});
  }
}
