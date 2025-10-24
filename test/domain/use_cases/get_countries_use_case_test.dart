import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_countries_use_case.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late GetCountriesUseCase useCase;
  late MockCountryInformationRepository repository;

  setUp(() {
    repository = MockCountryInformationRepository();
    useCase = GetCountriesUseCase(countryInformationRepository: repository);
  });

  group('GetCountriesUseCase', () {
    test('getCountries OK', () async {
      when(() => repository.getCountries()).thenAnswer(
          (_) async => const Right(CountriesResponse(countries: [])));

      await useCase.getCountries();

      verify(() => repository.getCountries()).called(1);
    });
  });
}
