
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/model/movie_model.dart';

class WatchlistState {
  final List<Movie> watchlist;

  WatchlistState(this.watchlist);
}

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(WatchlistState([]));

  void addToWatchlist(Movie movie) {
    if (!state.watchlist.any((m) => m.id == movie.id)) {
      emit(WatchlistState([...state.watchlist, movie]));
    }
  }

  void removeFromWatchlist(int movieId) {
    emit(WatchlistState(
      state.watchlist.where((m) => m.id != movieId).toList(),
    ));
  }

  bool isInWatchlist(int movieId) {
    return state.watchlist.any((m) => m.id == movieId);
  }
}