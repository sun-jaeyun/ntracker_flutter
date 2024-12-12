import 'package:flutter_test/flutter_test.dart';
import 'package:ntracker_flutter/ntracker_flutter.dart';
import 'package:ntracker_flutter/ntracker_flutter_platform_interface.dart';
import 'package:ntracker_flutter/ntracker_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNtrackerFlutterPlatform with MockPlatformInterfaceMixin implements NtrackerFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> initialize({required String android, required String ios, bool debug = false}) {
    throw UnimplementedError();
  }
}

void main() {
  final NtrackerFlutterPlatform initialPlatform = NtrackerFlutterPlatform.instance;

  test('$MethodChannelNtrackerFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNtrackerFlutter>());
  });

  test('getPlatformVersion', () async {
    NtrackerFlutter ntrackerFlutterPlugin = NtrackerFlutter();
    MockNtrackerFlutterPlatform fakePlatform = MockNtrackerFlutterPlatform();
    NtrackerFlutterPlatform.instance = fakePlatform;

    expect(await ntrackerFlutterPlugin.getPlatformVersion(), '42');
  });
}
