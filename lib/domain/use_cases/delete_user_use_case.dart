import 'package:prueba_jairo_rios/domain/repositories/user_repository.dart';

class DeleteUserUseCase {
  const DeleteUserUseCase({
    required this.userRepository,
  });

  final UserRepository userRepository;

  Future<void> deleteUser(int index) async =>
      await userRepository.deleteUser(index);
}
