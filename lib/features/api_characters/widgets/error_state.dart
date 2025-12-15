import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/features/api_characters/cubit/api_characters_cubit.dart';

class ErrorState extends StatelessWidget {
  final String message;

  const ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<ApiCharactersCubit>().loadCharacters();
            },
            child: const Text("Reintentar"),
          ),
        ],
      ),
    );
  }
}