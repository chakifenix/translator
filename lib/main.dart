import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';

import 'package:hive/hive.dart';
import 'package:translator1/features/home/presentation/bloc/home_state.dart';
import 'package:translator1/theme/dark_theme.dart';
import 'package:translator1/theme/light_theme.dart';

import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';
import 'features/home/presentation/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final path = await getTemporaryDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(TranslationModelAdapter());
  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ru')],
    path: 'translations',
    child: BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(Init()),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return MaterialApp(
            title: "Translator",
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: state.isDark == null || state.isDark == false
                ? lightTheme
                : darkTheme,
            darkTheme: state.isDark == null || state.isDark == true
                ? darkTheme
                : lightTheme,
            home: const HomeScreen());
      },
    );
  }
}
