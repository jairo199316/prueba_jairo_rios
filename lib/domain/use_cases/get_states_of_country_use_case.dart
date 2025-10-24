import 'package:dartz/dartz.dart';
import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';
import 'package:prueba_jairo_rios/domain/repositories/country_information_repository.dart';

class GetStatesOfCountryUseCase {
  const GetStatesOfCountryUseCase({
    required this.countryInformationRepository,
  });

  final CountryInformationRepository countryInformationRepository;

  Future<Either<Failure, StatesResponse>> getStatesOfCountry(String country) async =>
      await countryInformationRepository.getStatesOfCountry(country);
}
