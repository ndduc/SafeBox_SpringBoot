import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:safebox/hive-data/hive-model/SafeBoxModel.dart';
import 'package:safebox/ui/menu/MainMenu.dart';
import 'bloc/bloc/GalleryBloc.dart';
import 'bloc/bloc/SafeBoxBloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(SafeBoxModelAdapter());
  await Hive.openBox<SafeBoxModel>('safebox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        home: const MainMenu(),
      ),
    );
  }
}
