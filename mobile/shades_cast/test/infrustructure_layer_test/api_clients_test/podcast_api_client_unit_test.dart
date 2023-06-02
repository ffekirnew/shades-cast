import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shades_cast/Infrustructure_layer/api_clients/authService.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/constants.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

// Create a mock class for the AuthService
class MockAuthService extends Mock implements AuthService {}

// Create a mock class for the http.Client
class MockClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
      super.noSuchMethod(
        Invocation.method(#get, [url], {#headers: headers}),
        returnValue: Future.value(http.Response(
            '', 200)), // Add a default return value of type Future<Response>
      );
}

void main() {
  group('FunfactApiClient', () {
    late FunfactApiClient funfactApiClient;
    late MockAuthService mockAuthService;
    late MockClient mockClient;

    setUp(() {
      mockAuthService = MockAuthService();
      mockClient = MockClient();
      funfactApiClient = FunfactApiClient();
      funfactApiClient.authService = mockAuthService;
    });

    group('getFunfact', () {
      test('should return funfact on successful response', () async {
        final responseMap = {
          "id": 1,
          "title": "fact 1",
          "body": "some description"
        };
        final responseJson = jsonEncode(responseMap);
        final response = http.Response(responseJson, 200);

        when(mockClient.get(Uri.parse('$api/api/v3/resources/facts/')))
            .thenAnswer((_) async => response);

        final result = await funfactApiClient.getFunfact();

        expect(result, responseMap);
        verify(mockClient.get(Uri.parse('$api/api/v3/resources/facts/')));
      });

      test('should throw an exception on non-200 response', () async {
        final response = http.Response('Error', 404);

        // Move this 'when' call outside of the stub response block
        when(mockClient.get(Uri.parse('$api/api/v3/resources/facts/')))
            .thenAnswer((_) async => response);

        expect(funfactApiClient.getFunfact(), throwsException);
        verify(mockClient.get(Uri.parse('$api/api/v3/resources/facts/')));
      });
    });

    // Write tests for other methods in the FunfactApiClient class
    // using a similar approach as above.
  });
}
