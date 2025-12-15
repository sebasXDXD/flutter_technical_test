import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'features/preferences/data/models/character_preference_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();

  Hive.registerAdapter(CharacterPreferenceModelAdapter());

  await Hive.openBox<CharacterPreferenceModel>('preferences');

  runApp(const MyApp());
}
