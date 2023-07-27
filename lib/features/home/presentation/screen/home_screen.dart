// Make sure your Internet is Connected
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:translator1/features/favourites/presentation/page/favourites_screen.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';
import 'package:translator1/features/home/presentation/bloc/home_event.dart';
import 'package:translator1/features/home/presentation/bloc/home_state.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List of languages
  List<String> languages = [
    'English',
    'Hindi',
    'Arabic	',
    'German',
    'Russian',
    'Spanish',
    'Urdu',
    'Japanese	',
    'Italian'
  ];
  List<String> languagescode = [
    'en',
    'hi',
    'ar',
    'de',
    'ru',
    'es',
    'ur',
    'ja',
    'it'
  ];

  String from = 'en';
  String to = 'ru';
  String selectedvalue = 'English';
  String selectedvalue2 = 'Russian';
  String a = "";

  late HomeBloc bloc;

  @override
  void initState() {
    bloc = context.read();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   translate();
  // }

  _goToFavourites() {
    Navigator.of(context).push(FavouritesScreen.route());
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text("Drawer"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text("Settings"),
              selected: _selectedIndex == 0,
              onTap: () => _goToFavourites(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: Text(
          'translator'.tr(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => _goToFavourites())
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('from'.tr()),
                    const SizedBox(
                      width: 100,
                    ),
                    DropdownButton(
                      value: selectedvalue,
                      borderRadius: BorderRadius.circular(20),
                      focusColor: Colors.transparent,
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                          onTap: () {
                            if (lang == languages[0]) {
                              from = languagescode[0];
                            } else if (lang == languages[1]) {
                              from = languagescode[1];
                            } else if (lang == languages[2]) {
                              from = languagescode[2];
                            } else if (lang == languages[3]) {
                              from = languagescode[3];
                            } else if (lang == languages[4]) {
                              from = languagescode[4];
                            } else if (lang == languages[5]) {
                              from = languagescode[5];
                            } else if (lang == languages[6]) {
                              from = languagescode[6];
                            } else if (lang == languages[7]) {
                              from = languagescode[7];
                            } else if (lang == languages[8]) {
                              from = languagescode[8];
                            }
                            setState(() {});
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedvalue = value!;
                        bloc.add(SetFrom(from));
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Form(
                  child: TextFormField(
                    onChanged: (value) {
                      bloc.add(SetText(value));
                    },
                    maxLines: null,
                    minLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        hintText: 'enter'.tr(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (state.inFavourite) {
                              bloc.add(DeleteFromFavourites());
                            } else {
                              bloc.add(SaveToFavourites());
                            }
                          },
                          icon: Icon(state.inFavourite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Colors.white,
                        ),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        errorStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('to'.tr()),
                    const SizedBox(
                      width: 100,
                    ),
                    DropdownButton(
                      borderRadius: BorderRadius.circular(20),
                      value: selectedvalue2,
                      focusColor: Colors.transparent,
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                          onTap: () {
                            if (lang == languages[0]) {
                              to = languagescode[0];
                            } else if (lang == languages[1]) {
                              to = languagescode[1];
                            } else if (lang == languages[2]) {
                              to = languagescode[2];
                            } else if (lang == languages[3]) {
                              to = languagescode[3];
                            } else if (lang == languages[4]) {
                              to = languagescode[4];
                            } else if (lang == languages[5]) {
                              to = languagescode[5];
                            } else if (lang == languages[6]) {
                              to = languagescode[6];
                            } else if (lang == languages[7]) {
                              to = languagescode[7];
                            } else if (lang == languages[8]) {
                              to = languagescode[8];
                            }
                            setState(() {
                              print(lang);
                              print(from);
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedvalue2 = value!;
                        bloc.add(SetTo(to));
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: SelectableText(
                    state.model.translatedText ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () => bloc.add(Translate()),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 1, 96, 4)),
                      fixedSize: MaterialStatePropertyAll(Size(300, 45))),
                  child: state.isLoading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('translate'.tr())),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text('darkMode').tr(),
              ),
              Switch(
                value: state.isDark ?? false,
                onChanged: (value) {
                  bloc.add(SetDarkMode(value == true));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text('localization').tr(),
              ),
              Switch(
                value: context.locale.languageCode == 'ru',
                onChanged: (value) {
                  if (context.locale.languageCode == "ru") {
                    context.setLocale(Locale("en"));
                  } else {
                    context.setLocale(Locale('ru'));
                  }
                },
              ),
            ],
          );
        },
      )),
    );
  }
}
