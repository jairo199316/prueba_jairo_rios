import 'package:hive/hive.dart';
import 'package:prueba_jairo_rios/domain/entities/address_information.dart';

part 'address_information_model.g.dart';

@HiveType(typeId: 1)
class AddressInformationModel extends HiveObject {
  AddressInformationModel({
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });

  @HiveField(0)
  final String countryName;
  @HiveField(1)
  final String stateName;
  @HiveField(2)
  final String cityName;

  factory AddressInformationModel.fromEntity(AddressInformation entity) =>
      AddressInformationModel(
        countryName: entity.countryName,
        stateName: entity.stateName,
        cityName: entity.cityName,
      );

  AddressInformation toEntity() => AddressInformation(
        countryName: countryName,
        stateName: stateName,
        cityName: cityName,
      );
}
