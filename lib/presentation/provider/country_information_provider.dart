import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_jairo_rios/data/repositories_impl/country_information_repository_impl.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_cities_of_state_use_case.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_countries_use_case.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_states_of_country_use_case.dart';

final countryInformationRepositoryProvider =
Provider((ref) => CountryInformationRepositoryImpl());

final countriesFutureProvider = FutureProvider((ref) async {
  final repository = ref.watch(countryInformationRepositoryProvider);
  final getCountriesUseCase =
  GetCountriesUseCase(countryInformationRepository: repository);
  return await getCountriesUseCase.getCountries();
});

final statesFutureProvider = FutureProvider.family((ref, String country) async {
  final repository = ref.watch(countryInformationRepositoryProvider);
  final getStatesOfCountryUseCase =
  GetStatesOfCountryUseCase(countryInformationRepository: repository);
  return await getStatesOfCountryUseCase.getStatesOfCountry(country);
});

final citiesFutureProvider =
FutureProvider.family((ref, Map<String, dynamic> cityData) async {
  final repository = ref.watch(countryInformationRepositoryProvider);
  final getCitiesOfStateUseCase =
  GetCitiesOfStateUseCase(countryInformationRepository: repository);
  return await getCitiesOfStateUseCase.getCitiesOfState(
      cityData['country'], cityData['state']);
});
