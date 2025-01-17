// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_image_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenerateImageRecordAdapter extends TypeAdapter<GenerateImageRecord> {
  @override
  final int typeId = 1;

  @override
  GenerateImageRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenerateImageRecord(
      prompt: fields[0] as String,
      urls: (fields[1] as List?)?.cast<String>(),
    )
      ..generating = fields[2] as bool
      ..CreateDate = fields[3] as DateTime?
      ..isBrandNew = fields[4] as bool?;
  }

  @override
  void write(BinaryWriter writer, GenerateImageRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.prompt)
      ..writeByte(1)
      ..write(obj.urls)
      ..writeByte(2)
      ..write(obj.generating)
      ..writeByte(3)
      ..write(obj.CreateDate)
      ..writeByte(4)
      ..write(obj.isBrandNew);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenerateImageRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
