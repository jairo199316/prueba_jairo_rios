// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressInformationModelAdapter
    extends TypeAdapter<AddressInformationModel> {
  @override
  final int typeId = 1;

  @override
  AddressInformationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressInformationModel(
      countryName: fields[0] as String,
      stateName: fields[1] as String,
      cityName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddressInformationModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.countryName)
      ..writeByte(1)
      ..write(obj.stateName)
      ..writeByte(2)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressInformationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
