import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_jairo_rios/data/repositories_impl/country_information_repository_impl.dart';

import '../../core/utils/data_service_response.dart';
import '../mocks/data_mocks.dart';

void main() {
  late CountryInformationRepositoryImpl repository;
  late MockHttpClient mockClient;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockClient = MockHttpClient();
    repository = CountryInformationRepositoryImpl(client: mockClient);
  });

  group('CountryInformationRepositoryImpl', () {
    test('getCountries function OK', () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(
            jsonEncode(DataServiceResponse.getCountriesResponse), 200),
      );

      final result = await repository.getCountries();

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('No debería fallar'),
        (data) {
          expect(data.countries.length, 2);
          expect(data.countries.first, 'Colombia');
        },
      );
    });

    test('getCountries function failure', () async {
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 500));

      final result = await repository.getCountries();

      expect(result.isLeft(), true);
      result.fold(
        (failure) =>
            expect(failure.message, isNotEmpty),
        (_) => fail('Debería fallar'),
      );
    });

    test('getStatesOfCountry function Ok', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(
              jsonEncode(DataServiceResponse.getStatesResponse), 200));

      final result = await repository.getStatesOfCountry('Colombia');

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('No debería fallar'),
        (data) => expect(data.states.length, 2),
      );
    });

    test('getCitiesOfState function Ok', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(
              jsonEncode(DataServiceResponse.getCitiesResponse), 200));

      final result = await repository.getCitiesOfState('Colombia', 'Antioquia');

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('No debería fallar'),
        (data) => expect(data.cities, contains('Medellin')),
      );
    });

    test('getCitiesOfState function failure', () async {
      when(() => mockClient.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception('Error de red'));

      final result = await repository.getCitiesOfState('Colombia', 'Antioquia');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, isNotEmpty),
        (_) => fail('Debería fallar'),
      );
    });
  });
}
