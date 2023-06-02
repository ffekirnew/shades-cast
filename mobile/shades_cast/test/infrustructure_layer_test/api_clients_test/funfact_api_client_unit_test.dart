import 'dart:convert';

import 'package:shades_cast/Infrustructure_layer/api_clients/authService.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/funfact_api_client.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  late FunfactApiClient funfactApiClient;
  late MockHttpClient httpClient;
  late MockAuthService authService;

  setUp(() {
    httpClient = MockHttpClient();
    authService = MockAuthService();
    funfactApiClient = FunfactApiClient();
    funfactApiClient.authService = authService;
  });

  test('getFunfact returns funfact when HTTP response is successful', () async {
    final responseBody = '[{"fact": "Some fun fact"}]';
    final mockResponse = http.Response(responseBody, 200);

    when(authService.getToken()).thenAnswer((_) async => 'mock_token');
    when(httpClient.get(any ?? Uri())).thenAnswer((_) async => mockResponse);

    final result = await funfactApiClient.getFunfact();

    expect(result, isA<dynamic>());
    expect(result, json.decode(responseBody));
    verify(authService.getToken()).called(1);
    verify(httpClient.get(
        Uri.parse('YOUR_API_BASE_URL/api/v3/resources/facts/'),
        headers: {'Authorization': 'Token mock_token'})).called(1);
  });

  test('getFunfact throws an exception when HTTP response is not successful',
      () async {
    final mockResponse = http.Response('Error', 404);

    when(authService.getToken()).thenAnswer((_) async => 'mock_token');
    when(httpClient.get(any ?? Uri())).thenAnswer((_) async => mockResponse);

    expect(funfactApiClient.getFunfact(), throwsA('cannot get funfact'));
    verify(authService.getToken()).called(1);
    verify(httpClient.get(
        Uri.parse('YOUR_API_BASE_URL/api/v3/resources/facts/'),
        headers: {'Authorization': 'Token mock_token'})).called(1);
  });

  // Similar tests can be written for the other methods: addFunfact, updateFunfact, and deleteFunfact
}
