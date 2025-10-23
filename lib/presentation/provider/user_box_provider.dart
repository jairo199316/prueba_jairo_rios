import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';
import 'hive_provider.dart';

final userBoxProvider = FutureProvider<Box<UserInformationModel>>((ref) async {
  final hive = ref.read(hiveProvider);
  await Hive.initFlutter();
  final box = await hive.openBox<UserInformationModel>('users');
  return box;
});
