import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/styling/app_colors.dart';
import 'package:movie_app/Core/styling/app_styles.dart';
import 'package:movie_app/Data/Cubit/WatchlistCubit.dart';
import 'package:movie_app/Views/MovieCard.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        automaticallyImplyLeading: false,
        title: Text(
          'Watchlist',
          style: AppStyles.black18BoldStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state.watchlist.isEmpty) {
            return const Center(
              child: Text(
                'Your watchlist is empty',
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
            itemCount: state.watchlist.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: state.watchlist[index]);
            },
          );
        },
      ),
    );
  }
}
