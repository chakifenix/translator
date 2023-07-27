import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:translator1/core/api/dio_helper.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';
import 'package:translator1/features/home/presentation/bloc/home_event.dart';
import 'package:translator1/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late Box<TranslationModel> translations;
  late Box<bool> settings;
  HomeBloc() : super(HomeState.initial()) {
    on<Translate>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await DioManager().getData<Map<String, dynamic>>(
          url: "",
          query: {
            "langpair": "${state.model.from}|${state.model.to}",
            "q": state.model.text
          },
          onSuccess: (data) {
            try {
              final translatedText = (data['responseData']
                  as Map<String, dynamic>)['translatedText'];
              emit(state.copyWith(
                  model: state.model.copyWith(
                translatedText: translatedText,
              )));
              add(CheckIfModelInDb());
            } catch (e) {}
          },
          onError: (error) {
            debugPrint(error);
          });
      emit(state.copyWith(isLoading: false));
    });
    on<Init>((event, emit) async {
      translations = await Hive.openBox<TranslationModel>("favourites");
      settings = await Hive.openBox<bool>('settings');
      if (settings.keys.contains('isDark')) {
        emit(state.copyWith(isDark: settings.get('isDark')));
      }
    });

    on<SetText>((event, emit) async {
      emit(state.copyWith(
          model: state.model.copyWith(text: event.text, translatedText: "")));
      add(CheckIfModelInDb());
    });

    on<SetFrom>((event, emit) async {
      emit(state.copyWith(model: state.model.copyWith(from: event.from)));
      add(CheckIfModelInDb());
    });

    on<SetTo>((event, emit) async {
      emit(state.copyWith(model: state.model.copyWith(to: event.to)));
      if (state.model.text.isNotEmpty) {
        add(Translate());
      }
      add(CheckIfModelInDb());
    });

    on<DeleteFromFavourites>((event, emit) async {
      translations.delete(
          event.model == null ? state.model.getKey() : event.model?.getKey());
      emit(state.copyWith(inFav: false));
    });

    on<CheckIfModelInDb>((event, emit) async {
      // final index = translations.values.toList().indexWhere((element) =>
      //     element.from == state.model.from &&
      //     element.text.toLowerCase() == state.model.text.toLowerCase() &&
      //     element.to == state.model.to);
      emit(state.copyWith(
          inFav: translations.keys.contains(state.model.getKey())));
    });

    on<SaveToFavourites>((event, emit) async {
      if (state.model.text.isEmpty ||
          state.model.translatedText == null ||
          state.model.translatedText?.isEmpty == true) return;
      translations.put(state.model.getKey(), state.model);
      emit(state.copyWith(inFav: true));
    });

    on<SetDarkMode>((event, emit) async {
      settings.put("isDark", event.value);
      emit(state.copyWith(isDark: event.value));
    });
  }
}
