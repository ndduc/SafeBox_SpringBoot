import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebox/ui/SimpleBlocUi.dart';
import 'package:safebox/ui/menu/MainMenu.dart';

import 'bloc/bloc/CounterBloc.dart';
import 'bloc/bloc/GalleryBloc.dart';
import 'bloc/bloc/SafeBoxBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GalleryBloc>(
          create: (_) => GalleryBloc(),
        ),
        BlocProvider<SafeBoxBloc>(
          create: (_) => SafeBoxBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter BLoC Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainMenu(),
      ),
    );
  }
}
