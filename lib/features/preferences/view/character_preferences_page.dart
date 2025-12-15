import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/features/api_characters//widgets/head_tabs.dart';

import '../cubit/preference_cubit.dart';
import '../data/datasources/character_preference_local_datasource.dart';
import '../data/repositories/character_preference_repository.dart';
import '../widgets/preferences_body.dart';

class CharacterPreferencesPage extends StatelessWidget {
  const CharacterPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/prefs';

    return BlocProvider(
      create: (_) => PreferenceCubit(
        CharacterPreferenceRepository(
          CharacterPreferenceLocalDatasource(),
        ),
      )..loadAll(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Guardados'),
        ),
        body: Column(
          children: [
            HeaderTabs(currentRoute: currentRoute),
            const Expanded(child: PreferencesBody()),
          ],
        ),
      ),
    );
  }
}
