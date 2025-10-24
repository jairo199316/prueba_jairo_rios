import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_cities_of_state_use_case.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late GetCitiesOfStateUseCase useCase;
  late MockCountryInformationRepository repository;

  setUp(() {
    repository = MockCountryInformationRepository();
    useCase = GetCitiesOfStateUseCase(countryInformationRepository: repository);
  });

  group('GetCitiesOfStateUseCase', () {
    test('getCitiesOfState OK', () async {
      when(() => repository.getCitiesOfState(any(), any()))
          .thenAnswer((_) async => const Right(CitiesResponse(cities: [])));

      await useCase.getCitiesOfState('Colombia', 'Antioquia');

      verify(() => repository.getCitiesOfState(any(), any())).called(1);
    });
  });
}
