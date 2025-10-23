import 'package:prueba_jairo_rios/domain/entities/user_information.dart';

abstract class UserRepository {
  Future<void> saveUser(UserInformation user);

  Future<List<UserInformation>> getUsers();

  Future<void> deleteUser(int index);
}
