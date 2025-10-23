import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  const GetUsersUseCase({
    required this.userRepository,
  });

  final UserRepository userRepository;

  Future<List<UserInformation>> getUsers() async =>
      await userRepository.getUsers();
}
