import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_users_use_case.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late GetUsersUseCase useCase;
  late MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    useCase = GetUsersUseCase(userRepository: repository);
  });

  group('GetUsersUseCase', () {
    test('getUsers OK', () async {
      when(() => repository.getUsers()).thenAnswer((_) async => []);

      await useCase.getUsers();

      verify(() => repository.getUsers()).called(1);
    });
  });
}
