import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/features/api_characters/widgets/buttons/new_character_button.dart';
import 'package:rick_clean_app/features/api_characters/widgets/characters_body.dart';
import 'package:rick_clean_app/features/api_characters/widgets/head_tabs.dart';
import '../cubit/api_characters_cubit.dart';
import '../data/datasources/rick_morty_remote_datasource.dart';
import '../data/repositories/rick_morty_repository.dart';

class ApiListPage extends StatelessWidget {
  const ApiListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiCharactersCubit(
        RickMortyRepository(
          RickMortyRemoteDatasource(),
        ),
      )..loadCharacters(),
      child: const _ApiListPageContent(),
    );
  }
}

class _ApiListPageContent extends StatefulWidget {
  const _ApiListPageContent();

  @override
  State<_ApiListPageContent> createState() => _ApiListPageContentState();
}

class _ApiListPageContentState extends State<_ApiListPageContent> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '/api-list';

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar personaje en tiempo real...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
          autofocus: true,
          onChanged: (value) {
            context.read<ApiCharactersCubit>().searchCharacters(value);
          },
        )
            : const Text("Personajes"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  context.read<ApiCharactersCubit>().loadCharacters();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          HeaderTabs(currentRoute: currentRoute),
          const SizedBox(height: 16),
          const NewCharacterButton(),
          const SizedBox(height: 12),

           Expanded(
            child: CharactersBody(
              onRetryClearSearch: () {
                _searchController.clear();
                setState(() {
                  _isSearching = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}