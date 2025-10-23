import 'package:dartz/dartz.dart';
import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:prueba_jairo_rios/domain/repositories/country_information_repository.dart';

class GetCitiesOfStateUseCase {
  const GetCitiesOfStateUseCase({
    required this.countryInformationRepository,
  });

  final CountryInformationRepository countryInformationRepository;

  Future<Either<Failure, CitiesResponse>> getCitiesOfState(
          String country, String state) async =>
      await countryInformationRepository.getCitiesOfState(country, state);
}
