import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';
import 'package:prueba_jairo_rios/data/repositories_impl/country_information_repository_impl.dart';
import 'package:prueba_jairo_rios/data/repositories_impl/user_repository_impl.dart';

class MockCountryInformationRepositoryImpl extends Mock
    implements CountryInformationRepositoryImpl {}

class MockUserBox extends Mock implements Box<UserInformationModel> {}

class MockUserRepositoryImpl extends Mock implements UserRepositoryImpl {}
