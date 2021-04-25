import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expansion_navigation_rail/expansion_navigation_rail.dart';

void main() {
  const MethodChannel channel = MethodChannel('expansion_navigation_rail');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ExpansionNavigationRail.platformVersion, '42');
  });
}
