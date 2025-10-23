import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/domain/repositories/user_repository.dart';

class SaveUserUseCase {
  const SaveUserUseCase({
    required this.userRepository,
  });

  final UserRepository userRepository;

  Future<void> saveUser(UserInformation user) async =>
      await userRepository.saveUser(user);
}
