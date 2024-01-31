// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:repo_scout/api/api.dart';
import 'package:repo_scout/api/http_manager.dart';
import 'package:repo_scout/models/api_response_mode.dart';


class MockDio extends Mock implements Dio {}
void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  group('HttpManager', () {
    late Dio dio;
    late HttpManager httpManager;

    setUp(() {
      dio = MockDio();
      httpManager = HttpManager();
      httpManager.dio = dio; 
    });
    final url = Api.searchRepositories;
    test('get method returns ApiResponseMode on success', () async {
      

      final result = await httpManager.get(url: url,params: {
        'q': 'topic:flutter'
      });

      expect(result.apiMode, equals(ApiMode.online));
      expect(result.responseData['incomplete_results'], equals(false));
    });

    test('get method returns ApiResponseMode on failure', () async {
     

      final result = await httpManager.get(url: 'test_url');

      expect(result.apiMode, equals(ApiMode.online));
      expect(result.responseData['message'], equals('json_format_error'));
    });
  });
}
