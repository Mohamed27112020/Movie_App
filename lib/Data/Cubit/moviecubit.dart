import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/Cubit/moviestates.dart';
import 'package:movie_app/Data/serivices/services.dart';

class MovieCubit extends Cubit<MovieState> {
    
  final MovieApiService _apiService;
  int _currentPage = 1;
  String _currentCategory = 'popular';
  String? _searchQuery;

  MovieCubit(this._apiService) : super(MovieInitial());

  Future<void> loadMovies({int page = 1, String category = 'popular'}) async {
    try {
      emit(MovieLoading());
      _currentPage = page;
      _currentCategory = category;
      _searchQuery = null;

      final response = await _apiService.getMovies(
        page: page,
        category: category,
      );

      emit(
        MovieLoaded(
          movies: response.results,
          currentPage: response.page,
          totalPages: response.totalPages,
          category: category,
        ),
      );
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> searchMovies(String query, {int page = 1}) async {
    try {
      emit(MovieLoading());
      _currentPage = page;
      _searchQuery = query;

      final response = await _apiService.searchMovies(query: query, page: page);

      emit(
        MovieLoaded(
          movies: response.results,
          currentPage: response.page,
          totalPages: response.totalPages,
          category: 'search',
        ),
      );
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> nextPage() async {
    if (state is MovieLoaded) {
      final currentState = state as MovieLoaded;
      if (_currentPage < currentState.totalPages) {
        if (_searchQuery != null) {
          await searchMovies(_searchQuery!, page: _currentPage + 1);
        } else {
          await loadMovies(page: _currentPage + 1, category: _currentCategory);
        }
      }
    }
  }

  Future<void> previousPage() async {
    if (state is MovieLoaded && _currentPage > 1) {
      if (_searchQuery != null) {
        await searchMovies(_searchQuery!, page: _currentPage - 1);
      } else {
        await loadMovies(page: _currentPage - 1, category: _currentCategory);
      }
    }
  }

  Future<void> goToPage(int page) async {
    if (_searchQuery != null) {
      await searchMovies(_searchQuery!, page: page);
    } else {
      await loadMovies(page: page, category: _currentCategory);
    }
  }
}
