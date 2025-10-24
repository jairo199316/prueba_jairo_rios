import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_states_of_country_use_case.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late GetStatesOfCountryUseCase useCase;
  late MockCountryInformationRepository repository;

  setUp(() {
    repository = MockCountryInformationRepository();
    useCase =
        GetStatesOfCountryUseCase(countryInformationRepository: repository);
  });

  group('GetStatesOfCountryUseCase', () {
    test('getCountries OK', () async {
      when(() => repository.getStatesOfCountry(any()))
          .thenAnswer((_) async => const Right(StatesResponse(states: [])));

      await useCase.getStatesOfCountry('Colombia');

      verify(() => repository.getStatesOfCountry(any())).called(1);
    });
  });
}
