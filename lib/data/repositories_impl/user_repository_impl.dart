import 'package:hive/hive.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.userBox});

  final Box<UserInformationModel> userBox;

  @override
  Future<void> saveUser(UserInformation user) async {
    final userModel = UserInformationModel.fromEntity(user);
    await userBox.add(userModel);
  }

  @override
  Future<List<UserInformation>> getUsers() async {
    final userModels = userBox.values.toList();
    return userModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> deleteUser(int index) async {
    await userBox.deleteAt(index);
  }
}
