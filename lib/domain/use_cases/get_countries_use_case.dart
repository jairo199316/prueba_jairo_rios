import 'package:dartz/dartz.dart';
import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/repositories/country_information_repository.dart';

class GetCountriesUseCase {
  const GetCountriesUseCase({
    required this.countryInformationRepository,
  });

  final CountryInformationRepository countryInformationRepository;

  Future<Either<Failure, CountriesResponse>> getCountries() async =>
      await countryInformationRepository.getCountries();
}
