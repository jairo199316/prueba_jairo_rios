import 'package:hive/hive.dart';
import 'package:prueba_jairo_rios/data/models/address_information_model.dart';
import 'package:prueba_jairo_rios/domain/entities/user_information.dart';

part 'user_information_model.g.dart';

@HiveType(typeId: 0)
class UserInformationModel extends HiveObject {
  UserInformationModel({
    required this.name,
    required this.lastName,
    required this.birthday,
    required this.addresses,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String birthday;
  @HiveField(3)
  final List<AddressInformationModel> addresses;

  factory UserInformationModel.fromEntity(UserInformation entity) =>
      UserInformationModel(
        name: entity.name,
        lastName: entity.lastName,
        birthday: entity.birthday,
        addresses: entity.addresses
            .map((a) => AddressInformationModel.fromEntity(a))
            .toList(),
      );

  UserInformation toEntity() => UserInformation(
        name: name,
        lastName: lastName,
        birthday: birthday,
        addresses: addresses.map((a) => a.toEntity()).toList(),
      );
}
