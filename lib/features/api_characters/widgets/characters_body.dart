import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/global_error.dart';
import 'package:rick_clean_app/core/widgets/global_loading.dart';

import '../cubit/api_characters_cubit.dart';
import '../cubit/api_characters_state.dart';
import 'characters_list.dart';

class CharactersBody extends StatelessWidget {
  final VoidCallback? onRetryClearSearch;

  const CharactersBody({
    super.key,
    this.onRetryClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiCharactersCubit, ApiCharactersState>(
      builder: (context, state) {
        if (state is ApiCharactersLoading) {
          return const GlobalLoading();
        }

        if (state is ApiCharactersError) {
          return GlobalError(
            message: state.message,
            onRetry: () {
              onRetryClearSearch?.call();
              context.read<ApiCharactersCubit>().retry();
            },
          );
        }

        if (state is ApiCharactersSuccess) {
          if (state.characters.isEmpty) {
            return const Center(
              child: Text('No se encontraron personajes'),
            );
          }

          return CharactersList(characters: state.characters);
        }

        return const SizedBox();
      },
    );
  }
}

