import 'package:equatable/equatable.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Translate extends HomeEvent {
  Translate();
}

class Init extends HomeEvent {}

class SaveToFavourites extends HomeEvent {
  SaveToFavourites();
}

class DeleteFromFavourites extends HomeEvent {
  final TranslationModel? model;

  DeleteFromFavourites({this.model});
}

class SetText extends HomeEvent {
  final String text;

  SetText(this.text);
}

class SetFrom extends HomeEvent {
  final String from;

  SetFrom(this.from);
}

class SetTo extends HomeEvent {
  final String to;

  SetTo(this.to);
}

class CheckIfModelInDb extends HomeEvent {}

class SetDarkMode extends HomeEvent {
  final bool value;

  SetDarkMode(this.value);
}
