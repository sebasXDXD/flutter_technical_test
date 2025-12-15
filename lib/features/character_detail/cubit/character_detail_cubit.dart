import 'package:bloc/bloc.dart';
import 'package:rick_clean_app/features/character_detail/cubit/character_detail_state.dart';
import 'package:rick_clean_app/features/character_detail/data/repositories/character_detail_repository.dart';

class CharacterDetailCubit extends Cubit<CharacterDetailState> {
  final CharacterDetailRepository repository;

  CharacterDetailCubit(this.repository) : super(DetailInitial());

  Future<void> load(int id) async {
    emit(DetailLoading());

    try {
      final character = await repository.getById(id);
      emit(DetailSuccess(character));
    } catch (_) {
      emit(DetailError('Error al cargar el personaje'));
    }
  }
}
