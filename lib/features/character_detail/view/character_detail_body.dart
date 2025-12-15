import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/floating_back_button.dart';
import 'package:rick_clean_app/features/character_detail/cubit/character_detail_cubit.dart';
import 'package:rick_clean_app/features/character_detail/cubit/character_detail_state.dart';

import 'character_detail_form.dart';
class CharacterDetailBody extends StatelessWidget {
  final int characterId;

  const CharacterDetailBody({super.key, required this.characterId});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  int _opacityToAlpha(double opacity) => (opacity * 255).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DetailError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }
          if (state is DetailSuccess) {
            final c = state.character;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 280,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade900.withAlpha(_opacityToAlpha(0.6)),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      /// AVATAR
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Hero(
                          tag: 'character_${c.id}',
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.grey.shade800,
                            child: CircleAvatar(
                              radius: 85,
                              backgroundImage: NetworkImage(c.image),
                            ),
                          ),
                        ),
                      ),

                      /// FLOATING BACK BUTTON
                      Positioned(
                        top: 40,
                        left: 16,
                        child: FloatingBackButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// NAME
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      c.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(c.status).withAlpha(_opacityToAlpha(0.15)),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _getStatusColor(c.status), width: 1),
                    ),
                    child: Text(
                      '${c.status} • ${c.species}',
                      style: TextStyle(
                        color: _getStatusColor(c.status),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  CharacterDetailForm(character: c),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
