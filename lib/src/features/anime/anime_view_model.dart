import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/anime_model.dart';
import '../../core/providers.dart';
import '../../core/repository/anime_repository.dart';

class AnimeState {
  final List<AnimeModel> anime;
  final bool isLoading;
  final String? error;

  const AnimeState({
    this.anime = const [],
    this.isLoading = false,
    this.error,
  });

  AnimeState copyWith({
    List<AnimeModel>? anime,
    bool? isLoading,
    String? error,
  }) {
    return AnimeState(
      anime: anime ?? this.anime,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AnimeViewModel extends StateNotifier<AnimeState> {
  final AnimeRepository _repository;

  AnimeViewModel(this._repository) : super(const AnimeState()) {
    loadAnime();
  }

  Future<void> loadAnime() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final anime = await _repository.getAnime();
      state = state.copyWith(anime: anime, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadAnimeByCategory(int categoryId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final anime = await _repository.getAnimeByCategory(categoryId);
      state = state.copyWith(anime: anime, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final animeViewModelProvider =
    StateNotifierProvider<AnimeViewModel, AnimeState>((ref) {
  final repository = ref.watch(animeRepositoryProvider);
  return AnimeViewModel(repository);
});
