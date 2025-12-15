import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/global_loading.dart';
import '../cubit/preference_cubit.dart';
import '../cubit/preference_state.dart';
import 'preferences_list.dart';
import 'preferences_error.dart';

class PreferencesBody extends StatelessWidget {
  const PreferencesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceCubit, PreferenceState>(
      builder: (context, state) {
        if (state is PreferenceLoading) {
          return const GlobalLoading();
        }

        if (state is PreferenceError) {
          return PreferencesError(message: state.message);
        }

        if (state is PreferenceSuccess) {
          if (state.preferences.isEmpty) {
            return const Center(
              child: Text('No hay elementos guardados'),
            );
          }

          return PreferencesList(preferences: state.preferences);
        }

        return const SizedBox();
      },
    );
  }
}
