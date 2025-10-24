import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_jairo_rios/core/failure.dart';
import 'package:prueba_jairo_rios/core/strings_constants.dart';
import 'package:prueba_jairo_rios/domain/entities/cities_response.dart';
import 'package:prueba_jairo_rios/domain/entities/countries_response.dart';
import 'package:prueba_jairo_rios/domain/entities/states_response.dart';
import 'package:prueba_jairo_rios/domain/repositories/country_information_repository.dart';
import 'dart:convert';

class CountryInformationRepositoryImpl implements CountryInformationRepository {
  CountryInformationRepositoryImpl({http.Client? client})
      : client = client ?? http.Client();

  final http.Client client;

  @override
  Future<Either<Failure, CountriesResponse>> getCountries() async {
    try {
      final url = Uri.parse(StringConstants.countriesUrl);
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Right(CountriesResponse.fromJson(json));
      } else {
        return Left(
          Failure(
              message: '$StringConstants.getDataError: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(Failure(message: '$StringConstants.error: $e'));
    }
  }

  @override
  Future<Either<Failure, StatesResponse>> getStatesOfCountry(
      String country) async {
    try {
      final url = Uri.parse(
        '${StringConstants.statesUrl}${Uri.encodeComponent(country)}',
      );

      final response = await client.get(
        url,
        headers: {StringConstants.contentType: StringConstants.applicationJson},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Right(StatesResponse.fromJson(json));
      } else {
        return Left(
          Failure(
              message: '$StringConstants.getDataError: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(Failure(message: '$StringConstants.error: $e'));
    }
  }

  @override
  Future<Either<Failure, CitiesResponse>> getCitiesOfState(
      String country, String state) async {
    try {
      final url = Uri.parse(
        '${StringConstants.citiesUrl}${Uri.encodeComponent(country)}&state=${Uri.encodeComponent(state)}',
      );

      final response = await client.get(
        url,
        headers: {StringConstants.contentType: StringConstants.applicationJson},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Right(CitiesResponse.fromJson(json));
      } else {
        return Left(
          Failure(
              message: '$StringConstants.getDataError: ${response.statusCode}'),
        );
      }
    } catch (e) {
      return Left(Failure(message: '$StringConstants.error: $e'));
    }
  }
}
