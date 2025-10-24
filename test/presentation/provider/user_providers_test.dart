import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_box_provider.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_provider.dart';

import '../mocks/presentation_mocks.dart';

void main() {
  late MockUserBox mockBox;
  late MockUserRepositoryImpl mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockBox = MockUserBox();
    mockRepo = MockUserRepositoryImpl();

    container = ProviderContainer(
      overrides: [
        userBoxProvider.overrideWith((ref) async => mockBox),
        userRepositoryProvider.overrideWith((ref) async => mockRepo),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('UserProvider Tests', () {
    const userInformation = UserInformation(
      name: 'Jairo',
      lastName: 'Rios',
      birthday: '25/04/1993',
      addresses: [],
    );

    test('saveUser OK', () async {
      when(() => mockRepo.saveUser(userInformation)).thenAnswer((_) async {});

      await container.read(saveUserFutureProvider(userInformation).future);

      verify(() => mockRepo.saveUser(userInformation)).called(1);
    });

    test('getUsers OK', () async {
      final users = [userInformation];
      when(() => mockRepo.getUsers()).thenAnswer((_) async => users);

      final result = await container.read(getUsersFutureProvider.future);

      expect(result, equals(users));
      verify(() => mockRepo.getUsers()).called(1);
    });

    test('deleteUser OK', () async {
      when(() => mockRepo.deleteUser(0)).thenAnswer((_) async {});

      await container.read(deleteUserFutureProvider(0).future);

      verify(() => mockRepo.deleteUser(0)).called(1);
    });
  });
}
