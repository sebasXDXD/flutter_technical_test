import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/global_error.dart';
import 'package:rick_clean_app/core/widgets/global_loading.dart';
import 'package:rick_clean_app/features/api_characters/cubit/api_characters_cubit.dart';
import 'package:rick_clean_app/features/api_characters/cubit/api_characters_state.dart';
import 'package:rick_clean_app/features/api_characters/data/models/api_character_model.dart';
import 'package:rick_clean_app/features/character_detail/cubit/character_detail_cubit.dart';
import 'package:rick_clean_app/features/character_detail/data/datasources/character_detail_remote_datasource.dart';
import 'package:rick_clean_app/features/character_detail/data/repositories/character_detail_repository.dart';
import 'package:rick_clean_app/features/character_detail/view/character_detail_body.dart';

class CharacterNewPreferenceBody extends StatefulWidget {
  const CharacterNewPreferenceBody({super.key});

  @override
  State<CharacterNewPreferenceBody> createState() =>
      _CharacterNewPreferenceBodyState();
}

class _CharacterNewPreferenceBodyState
    extends State<CharacterNewPreferenceBody> {
  final TextEditingController _searchCtrl = TextEditingController();
  CharacterModel? _selected;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 70,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: BlocBuilder<ApiCharactersCubit, ApiCharactersState>(
        builder: (context, state) {
          if (state is ApiCharactersLoading) {
            return const GlobalLoading();
          }
          if (state is ApiCharactersError) {
            return GlobalError(
              message: state.message,
              onRetry: () {
                context.read<ApiCharactersCubit>().loadCharacters();
              },
            );
          }

          if (state is ApiCharactersSuccess) {
            final query = _searchCtrl.text.trim();

            final filtered = state.characters
                .where(
                  (c) => c.name.toLowerCase().contains(query.toLowerCase()),
            )
                .take(5)
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar personaje',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                ),

                const SizedBox(height: 12),

                if (query.isNotEmpty && filtered.isEmpty)
                  GlobalError(
                    message: 'No se encontraron personajes',
                    onRetry: () {
                      _searchCtrl.clear();
                      setState(() {});
                    },
                  ),


                if (filtered.isNotEmpty)
                  ...filtered.map(
                        (c) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(c.image),
                      ),
                      title: Text(c.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => CharacterDetailCubit(
                                CharacterDetailRepository(
                                  CharacterDetailRemoteDatasource(),
                                ),
                              )..load(c.id),
                              child: CharacterDetailBody(
                                characterId: c.id,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          }


          return const SizedBox();
        },
      ),
    );
  }
}
