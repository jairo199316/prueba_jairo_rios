import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:prueba_jairo_rios/presentation/provider/country_information_provider.dart';

import '../mocks/presentation_mocks.dart';

void main() {
  late MockCountryInformationRepositoryImpl mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockCountryInformationRepositoryImpl();
    container = ProviderContainer(
      overrides: [
        countryInformationRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('CountryInformationProvider Tests', () {
    test('getCountries OK', () async {
      const countriesResponse = CountriesResponse(countries: []);
      when(() => mockRepository.getCountries())
          .thenAnswer((_) async => const Right(countriesResponse));

      final result = await container.read(countriesFutureProvider.future);

      expect(result.isRight(), true);
      verify(() => mockRepository.getCountries()).called(1);
    });

    test('getStatesOfCountry OK', () async {
      const statesResponse = StatesResponse(states: []);
      when(() => mockRepository.getStatesOfCountry('Colombia'))
          .thenAnswer((_) async => const Right(statesResponse));

      final result =
          await container.read(statesFutureProvider('Colombia').future);

      expect(result.isRight(), true);
      verify(() => mockRepository.getStatesOfCountry('Colombia')).called(1);
    });

    test('getCitiesOfState OK', () async {
      const citiesResponse = CitiesResponse(cities: []);
      when(() => mockRepository.getCitiesOfState('Colombia', 'Antioquia'))
          .thenAnswer((_) async => const Right(citiesResponse));

      final result = await container.read(
        citiesFutureProvider({'country': 'Colombia', 'state': 'Antioquia'})
            .future,
      );

      expect(result.isRight(), true);
      verify(() => mockRepository.getCitiesOfState('Colombia', 'Antioquia'))
          .called(1);
    });

    test('getCountries Failure', () async {
      when(() => mockRepository.getCountries()).thenAnswer(
        (_) async => const Left(Failure(message: 'Error de red')),
      );

      final result = await container.read(countriesFutureProvider.future);

      expect(result.isLeft(), true);
    });
  });
}
