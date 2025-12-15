import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/floating_back_button.dart';
import 'package:rick_clean_app/features/api_characters/cubit/api_characters_cubit.dart';
import 'package:rick_clean_app/features/api_characters/data/datasources/rick_morty_remote_datasource.dart';
import 'package:rick_clean_app/features/api_characters/data/repositories/rick_morty_repository.dart';

import '../widgets/api_character_dropdown_page_body.dart';

class CharacterNewPreferencePage extends StatelessWidget {
  const CharacterNewPreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiCharactersCubit(
        RickMortyRepository(
          RickMortyRemoteDatasource(),
        ),
      )..loadCharacters(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guardar personaje'),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            const CharacterNewPreferenceBody(),

            Positioned(
              top: 16,
              left: 16,
              child: FloatingBackButton(
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
