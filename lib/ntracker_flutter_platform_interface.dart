import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ntracker_flutter_method_channel.dart';

abstract class NtrackerFlutterPlatform extends PlatformInterface {
  /// Constructs a NtrackerFlutterPlatform.
  NtrackerFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static NtrackerFlutterPlatform _instance = MethodChannelNtrackerFlutter();

  /// The default instance of [NtrackerFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelNtrackerFlutter].
  static NtrackerFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NtrackerFlutterPlatform] when
  /// they register themselves.
  static set instance(NtrackerFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initialize({required String android, required String ios, bool debug = false}) {
    throw UnimplementedError('initialize() has not been implemented.');
  }
}
