// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInformationModelAdapter extends TypeAdapter<UserInformationModel> {
  @override
  final int typeId = 0;

  @override
  UserInformationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInformationModel(
      name: fields[0] as String,
      lastName: fields[1] as String,
      birthday: fields[2] as String,
      addresses: (fields[3] as List).cast<AddressInformationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserInformationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.birthday)
      ..writeByte(3)
      ..write(obj.addresses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
