
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/Cubit/moviestates.dart';
import 'package:movie_app/Data/serivices/Movieservices.dart';

class SearchCubit extends Cubit<MovieState> {
  final MovieService movieService;

  SearchCubit(this.movieService) : super(MovieInitial());

  Future<void> searchMovies(String query, {int page = 1}) async {
    if (query.isEmpty) {
      emit(MovieInitial());
      return;
    }

    emit(MovieLoading());
    try {
      final response = await movieService.searchMovies(query, page: page);
      emit(MovieLoaded(
        movies: response.results,
        currentPage: response.page,
        totalPages: response.totalPages,
        category: 'Search',
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}