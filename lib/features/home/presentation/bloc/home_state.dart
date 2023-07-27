import 'package:equatable/equatable.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';

class HomeState extends Equatable {
  final TranslationModel model;
  final bool inFavourite;
  final bool isLoading;
  final bool? isDark;
  const HomeState(this.model, this.inFavourite, this.isLoading, this.isDark);

  factory HomeState.initial() {
    return HomeState(
        TranslationModel(from: "en", to: "ru", text: "", translatedText: null),
        false,
        false,
        null);
  }

  HomeState copyWith(
      {TranslationModel? model, bool? inFav, bool? isLoading, bool? isDark}) {
    return HomeState(model ?? this.model, inFav ?? this.inFavourite,
        isLoading ?? this.isLoading, isDark ?? this.isDark);
  }

  @override
  List<Object?> get props => [model, inFavourite, isLoading, isDark];
}
