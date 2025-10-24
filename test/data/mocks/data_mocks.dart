import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';

class MockUserBox extends Mock implements Box<UserInformationModel> {}

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}
