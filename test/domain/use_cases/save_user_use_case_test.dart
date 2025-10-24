import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/domain/use_cases/save_user_use_case.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late SaveUserUseCase useCase;
  late MockUserRepository repository;

  const userInformation = UserInformation(
    name: 'Jairo',
    lastName: 'Rios',
    birthday: '25/04/1993',
    addresses: [],);

  setUp(() {
    registerFallbackValue(userInformation);
    repository = MockUserRepository();
    useCase = SaveUserUseCase(userRepository: repository);
  });

  group('SaveUserUseCase', () {
    test('saveUser OK', () async {
      when(() => repository.saveUser(any())).thenAnswer((_) async {});

      await useCase.saveUser(userInformation);

      verify(() => repository.saveUser(userInformation)).called(1);
    });
  });
}
