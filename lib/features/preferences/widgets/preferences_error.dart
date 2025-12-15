import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/preference_cubit.dart';

class PreferencesError extends StatelessWidget {
  final String message;

  const PreferencesError({super.key, required this.message});

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
              context.read<PreferenceCubit>().loadAll();
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
