import 'package:movie_app/Data/model/movie_model.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final int currentPage;
  final int totalPages;
  final String category;

  MovieLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.category,
  });
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
