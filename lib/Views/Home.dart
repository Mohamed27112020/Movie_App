import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Data/Cubit/moviecubit.dart';
import 'package:movie_app/Data/Cubit/moviestates.dart';
import 'package:movie_app/Data/model/movie_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/Views/detailsmovie.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'popular';

  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().loadMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabs(),
            Expanded(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is MovieLoaded) {
                    return Column(
                      children: [
                        Expanded(child: _buildMovieGrid(state.movies)),
                        buildPagination(state),
                      ],
                    );
                  } else if (state is MovieError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What do you want to watch?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF2A2A3E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon:
                  _searchController.text.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MovieCubit>().loadMovies();
                        },
                      )
                      : null,
            ),
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<MovieCubit>().searchMovies(query);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = [
      {'label': 'Now Playing', 'value': 'now_playing'},
      {'label': 'Upcoming', 'value': 'upcoming'},
      {'label': 'Top Rated', 'value': 'top_rated'},
      {'label': 'Popular', 'value': 'popular'},
    ];

    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2A2A3E), width: 1)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = _selectedTab == tab['value'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = tab['value']!;
              });
              context.read<MovieCubit>().loadMovies(category: tab['value']!);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  tab['label']!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieGrid(List<Movie> movies) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return buildMovieCard(movie);
      },
    );
  }

  Widget buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  movie.posterUrl.isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: movie.posterUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder:
                            (context, url) => Container(
                              color: const Color(0xFF2A2A3E),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Container(
                              color: const Color(0xFF2A2A3E),
                              child: const Icon(
                                Icons.movie,
                                color: Colors.grey,
                              ),
                            ),
                      )
                      : Container(
                        color: const Color(0xFF2A2A3E),
                        child: const Icon(Icons.movie, color: Colors.grey),
                      ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPagination(MovieLoaded state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        border: Border(top: BorderSide(color: Color(0xFF2A2A3E), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          SizedBox(
            width: 80,
            height: 36,
            child: ElevatedButton(
              onPressed:
                  state.currentPage > 1
                      ? () => context.read<MovieCubit>().previousPage()
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A2A3E),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(
                  0xFF2A2A3E,
                ).withOpacity(0.5),
                disabledForegroundColor: Colors.grey,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.chevron_left, size: 20),
            ),
          ),

          // Page Numbers
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = getStartPage(state); i <= getEndPage(state); i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: GestureDetector(
                      onTap: () => context.read<MovieCubit>().goToPage(i),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color:
                              state.currentPage == i
                                  ? Colors.blue
                                  : const Color(0xFF2A2A3E),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '$i',
                            style: TextStyle(
                              color:
                                  state.currentPage == i
                                      ? Colors.white
                                      : Colors.grey,
                              fontSize: 12,
                              fontWeight:
                                  state.currentPage == i
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Next Button
          SizedBox(
            width: 80,
            height: 36,
            child: ElevatedButton(
              onPressed:
                  state.currentPage < state.totalPages
                      ? () => context.read<MovieCubit>().nextPage()
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A2A3E),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(
                  0xFF2A2A3E,
                ).withOpacity(0.5),
                disabledForegroundColor: Colors.grey,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.chevron_right, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  int getStartPage(MovieLoaded state) {
    if (state.currentPage <= 2) return 1;
    if (state.currentPage >= state.totalPages - 1) {
      return (state.totalPages - 3).clamp(1, state.totalPages);
    }
    return state.currentPage - 1;
  }

  int getEndPage(MovieLoaded state) {
    if (state.currentPage <= 2) {
      return (4).clamp(1, state.totalPages);
    }
    if (state.currentPage >= state.totalPages - 1) {
      return state.totalPages;
    }
    return (state.currentPage + 1).clamp(1, state.totalPages);
  }
}
