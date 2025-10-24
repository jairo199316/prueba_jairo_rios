import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/domain/use_cases/delete_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/domain_mocks.dart';

void main() {
  late DeleteUserUseCase useCase;
  late MockUserRepository repository;

  setUp(() {
    repository = MockUserRepository();
    useCase = DeleteUserUseCase(userRepository: repository);
  });

  group('DeleteUserUseCase', () {
    test('deleteUser OK', () async {
      when(() => repository.deleteUser(any())).thenAnswer((_) async {});

      await useCase.deleteUser(0);

      verify(() => repository.deleteUser(0)).called(1);
    });
  });
}
