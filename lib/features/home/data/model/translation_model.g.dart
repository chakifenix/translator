// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslationModelAdapter extends TypeAdapter<TranslationModel> {
  @override
  final int typeId = 0;

  @override
  TranslationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslationModel(
      from: fields[0] as String,
      to: fields[1] as String,
      text: fields[2] as String,
      translatedText: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TranslationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.translatedText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
