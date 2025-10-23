import 'package:prueba_jairo_rios/domain/entities/address_information.dart';

class UserInformation {
  const UserInformation({
    required this.name,
    required this.lastName,
    required this.birthday,
    required this.addresses,
  });

  final String name;
  final String lastName;
  final String birthday;
  final List<AddressInformation> addresses;
}
