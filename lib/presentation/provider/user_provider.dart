import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_jairo_rios/data/repositories_impl/user_repository_impl.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';
import 'package:prueba_jairo_rios/domain/use_cases/delete_user_use_case.dart';
import 'package:prueba_jairo_rios/domain/use_cases/get_users_use_case.dart';
import 'package:prueba_jairo_rios/domain/use_cases/save_user_use_case.dart';
import 'package:prueba_jairo_rios/presentation/provider/user_box_provider.dart';

final userRepositoryProvider = FutureProvider<UserRepositoryImpl>((ref) async {
  final box = await ref.watch(userBoxProvider.future);
  return UserRepositoryImpl(userBox: box);
});

final saveUserFutureProvider =
    FutureProvider.family((ref, UserInformation user) async {
  final repo = await ref.watch(userRepositoryProvider.future);
  final useCase = SaveUserUseCase(userRepository: repo);
  return await useCase.saveUser(user);
});

final getUsersFutureProvider = FutureProvider((ref) async {
  final repo = await ref.watch(userRepositoryProvider.future);
  final useCase = GetUsersUseCase(userRepository: repo);
  return await useCase.getUsers();
});

final deleteUserFutureProvider = FutureProvider.family((ref, int index) async {
  final repo = await ref.watch(userRepositoryProvider.future);
  final useCase = DeleteUserUseCase(userRepository: repo);
  return await useCase.deleteUser(index);
});
