// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:repo_scout/api/api.dart';
import 'package:repo_scout/api/http_manager.dart';
import 'package:repo_scout/models/api_response_mode.dart';
import 'package:repo_scout/models/query.dart';
import 'package:repo_scout/models/repo.dart';
import 'package:repo_scout/repository/remote_repository.dart';

// class MockDio extends Mock implements Dio {}

// class MockApi extends Mock implements Api {}

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
    // late Dio dio;
    late HttpManager httpManager;

    setUp(() {
      // dio = MockDio();
      httpManager = HttpManager();
      // httpManager.dio = dio;
    });
    final url = Api.searchRepositories;
    test('get method returns ApiResponseMode on success', () async {
      final result =
          await httpManager.get(url: url, params: {'q': 'topic:flutter'});

      expect(result.apiMode, equals(ApiMode.online));
      expect(result.responseData['incomplete_results'], equals(false));
    });

    test('get method returns ApiResponseMode on failure', () async {
      final result = await httpManager.get(url: 'test_url');

      expect(result.apiMode, equals(ApiMode.online));
      expect(result.responseData['message'], equals('json_format_error'));
    });
  });

  group('RemoteRepository', () {
    // late Api mockApi;
    late RemoteRepository remoteRepository;

    setUp(() {
      // mockApi = MockApi();
      remoteRepository = RemoteRepository(api: Api());

      // Assuming you have a static method to set the Api instance
    });
    test('getRepositories returns a list of repos', () async {
      // Arrange
      final query = Query(q: 'topic:Flutter');

      // expect(
      //     mockApi.getRepositories(query.toMap()),
      //     Future.value(ApiResponse(
      //         incompleteResults: false,
      //         items: [],
      //         totalCount: 0,
      //         message: 'success')));
      // when(mockApi.getRepositories(query.toMap())).thenAnswer(
      //   (_) async => Future.value(
      //     ApiResponse(
      //         incompleteResults: false,
      //         items: [],
      //         totalCount: 0,
      //         message: 'success'),
      //   ),
      // );

      // Act
      final result = await remoteRepository.getRepositories(query);

      // Assert
      expect(result, isNotNull);
      expect(result, isInstanceOf<List<Repo>>());
      // Add more assertions based on your requirements
    });
  });
}
