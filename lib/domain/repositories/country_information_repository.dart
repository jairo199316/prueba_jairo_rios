import 'package:dartz/dartz.dart';
import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';

abstract class CountryInformationRepository {
  Future<Either<Failure, CountriesResponse>> getCountries();

  Future<Either<Failure, StatesResponse>> getStatesOfCountry(String country);

  Future<Either<Failure, CitiesResponse>> getCitiesOfState(
      String country, String state);
}
