import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'features/preferences/cubit/preference_cubit.dart';
import 'features/preferences/data/datasources/character_preference_local_datasource.dart';
import 'features/preferences/data/repositories/character_preference_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterPreferenceRepository>(
          create: (_) => CharacterPreferenceRepository(
            CharacterPreferenceLocalDatasource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PreferenceCubit>(
            create: (context) => PreferenceCubit(
              context.read<CharacterPreferenceRepository>(),
            )..loadAll(),
          ),
        ],
        child: MaterialApp(
          title: 'Rick Clean App',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.apiList,
          routes: AppRoutes.routes,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade900,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
              surface: Colors.grey.shade900,
            ),

            fontFamily: 'Roboto',

            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
              headlineMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              titleLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              bodyMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelLarge: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
