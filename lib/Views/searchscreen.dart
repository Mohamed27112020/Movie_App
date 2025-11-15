import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/Cubit/Searchcubit.dart';
import 'package:movie_app/Data/Cubit/moviecubit.dart';
import 'package:movie_app/Data/Cubit/moviestates.dart';
import 'package:movie_app/Data/serivices/Movieservices.dart';
import 'package:movie_app/Views/MovieCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        automaticallyImplyLeading: false,
        title: TextField(
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
          ),
          onChanged: (query) {
            context.read<MovieCubit>().searchMovies(query);
          },
        ),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            return const Center(
              child: Text(
                'Search for movies',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (state is MovieError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is MovieLoaded) {
            if (state.movies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: state.movies[index]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
