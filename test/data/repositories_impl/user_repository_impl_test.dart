import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';
import 'package:prueba_jairo_rios/data/repositories_impl/user_repository_impl.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import '../mocks/data_mocks.dart';

void main() {
  late MockUserBox mockUserBox;
  late UserRepositoryImpl repository;

  const userEntity = UserInformation(
    name: 'Jairo',
    lastName: 'Rios',
    birthday: '25/04/1993',
    addresses: [],
  );

  final userModel = UserInformationModel.fromEntity(userEntity);

  setUp(() {
    registerFallbackValue(userModel);
    mockUserBox = MockUserBox();
    repository = UserRepositoryImpl(userBox: mockUserBox);
  });

  group('UserRepositoryImpl', () {
    test('saveUser OK', () async {
      when(() => mockUserBox.add(any())).thenAnswer((_) async => 0);

      await repository.saveUser(userEntity);

      verify(() => mockUserBox.add(any())).called(1);
    });

    test('getUsers OK', () async {
      when(() => mockUserBox.values).thenReturn([userModel]);

      final result = await repository.getUsers();

      expect(result, isA<List<UserInformation>>());
      expect(result.length, 1);
      expect(result.first.name, 'Jairo');
    });

    test('deleteUser OK', () async {
      when(() => mockUserBox.deleteAt(any())).thenAnswer((_) async {});

      await repository.deleteUser(0);

      verify(() => mockUserBox.deleteAt(0)).called(1);
    });
  });
}
