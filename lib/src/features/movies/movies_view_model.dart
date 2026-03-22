import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/movie_model.dart';
import '../../core/providers.dart';
import '../../core/repository/movies_repository.dart';

class MoviesState {
  final List<MovieModel> movies;
  final bool isLoading;
  final String? error;

  const MoviesState({
    this.movies = const [],
    this.isLoading = false,
    this.error,
  });

  MoviesState copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    String? error,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MoviesViewModel extends StateNotifier<MoviesState> {
  final MoviesRepository _repository;

  MoviesViewModel(this._repository) : super(const MoviesState()) {
    loadMovies();
  }

  Future<void> loadMovies() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final movies = await _repository.getMovies();
      state = state.copyWith(movies: movies, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadMoviesByCategory(int categoryId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final movies = await _repository.getMoviesByCategory(categoryId);
      state = state.copyWith(movies: movies, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final moviesViewModelProvider =
    StateNotifierProvider<MoviesViewModel, MoviesState>((ref) {
  final repository = ref.watch(moviesRepositoryProvider);
  return MoviesViewModel(repository);
});
