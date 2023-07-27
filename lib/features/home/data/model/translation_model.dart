import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'translation_model.g.dart';

@HiveType(typeId: 0)
class TranslationModel extends Equatable {
  @HiveField(0)
  final String from;
  @HiveField(1)
  final String to;
  @HiveField(2)
  final String text;
  @HiveField(3)
  final String? translatedText;

  TranslationModel(
      {required this.from,
      required this.to,
      required this.text,
      required this.translatedText});

  String getKey() => "$from${text.toLowerCase()}$to";

  TranslationModel copyWith(
      {String? from, String? to, String? text, String? translatedText}) {
    return TranslationModel(
        from: from ?? this.from,
        to: to ?? this.to,
        text: text ?? this.text,
        translatedText: translatedText ?? this.translatedText);
  }

  @override
  List<Object?> get props => [from, to, text, translatedText];
}
