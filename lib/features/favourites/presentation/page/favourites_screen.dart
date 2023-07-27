import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:translator1/features/home/data/model/translation_model.dart';
import 'package:translator1/features/home/presentation/bloc/home_event.dart';

import '../../../home/presentation/bloc/home_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider.value(
        value: context.read<HomeBloc>(),
        child: FavouritesScreen(),
      ),
    );
  }

  // final String a;
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('favourite'.tr())),
        body: ValueListenableBuilder(
            valueListenable:
                Hive.box<TranslationModel>('favourites').listenable(),
            builder: (context, box, widget) {
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  final item = box.values.toList()[index];
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade100),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.text),
                              SizedBox(height: 8),
                              Text(item.translatedText ?? "")
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () => context
                                .read<HomeBloc>()
                                .add(DeleteFromFavourites(model: item)),
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
