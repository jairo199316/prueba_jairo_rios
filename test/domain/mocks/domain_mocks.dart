import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/domain/repositories/country_information_repository.dart';
import 'package:prueba_jairo_rios/domain/repositories/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockCountryInformationRepository extends Mock implements CountryInformationRepository {}
