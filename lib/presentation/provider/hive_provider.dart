import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prueba_jairo_rios/data/models/address_information_model.dart';
import 'package:prueba_jairo_rios/data/models/user_information_model.dart';

final hiveProvider = Provider(<HiveInterface>(ref) {
  final hive = Hive;
  hive.registerAdapter(UserInformationModelAdapter());
  hive.registerAdapter(AddressInformationModelAdapter());
  return hive;
});
