import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/Cubit/WatchlistCubit.dart';
import 'package:movie_app/Data/model/movie_model.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie? movie;

  const MovieDetailScreen({Key? key, this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Handle null movie case
    if (widget.movie == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1F1D2B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F1D2B),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text(
            'No movie data available',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    final movie = widget.movie!;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      body: CustomScrollView(
        slivers: [
          // App Bar with backdrop image
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: const Color(0xFF1F1D2B),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Backdrop image
                  movie.backdropUrl.isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: movie.backdropUrl,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) =>
                                Container(color: const Color(0xFF2A2A3E)),
                        errorWidget:
                            (context, url, error) => Container(
                              color: const Color(0xFF2A2A3E),
                              child: const Icon(
                                Icons.movie,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                      )
                      : Container(
                        color: const Color(0xFF2A2A3E),
                        child: const Icon(
                          Icons.movie,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),

                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          const Color(0xFF1F1D2B).withOpacity(0.7),
                          const Color(0xFF1F1D2B),
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),

                  // Poster and rating at bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Poster
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                movie.posterUrl.isNotEmpty
                                    ? CachedNetworkImage(
                                      imageUrl: movie.posterUrl,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => Container(
                                            color: const Color(0xFF2A2A3E),
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
                                      child: const Icon(
                                        Icons.movie,
                                        color: Colors.grey,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Rating
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF8700),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Movie details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Info row (year, duration, genre)
                  Row(
                    
                    children: [
                      _buildInfoChip(
                        Icons.calendar_today,
                        movie.releaseDate.split('-').first,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.video_library,
                        '${movie.popularity}', // You can calculate from API if available
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.theater_comedy,
                        movie.releaseDate, // Get from genre_ids
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: const Color(0xFF12CDD9),
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'About Movie'),
                        //       Tab(text: 'Reviews'),
                        Tab(text: 'Cast'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tab content
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // About Movie Tab
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.overview.isNotEmpty
                                    ? movie.overview
                                    : 'No description available.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(
                                'Original Title',
                                movie.originalTitle,
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow('Release Date', movie.releaseDate),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                'Language',
                                movie.originalLanguage.toUpperCase(),
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                'Rating',
                                '${movie.voteAverage.toStringAsFixed(1)} (${movie.voteCount} votes)',
                              ),
                            ],
                          ),
                        ),

                        // // Reviews Tab
                        // Center(
                        //   child: Text(
                        //     'No reviews available',
                        //     style: TextStyle(
                        //       color: Colors.white.withOpacity(0.5),
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // ),

                        // Cast Tab
                        Center(
                          child: Text(
                            'Cast information not available',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<WatchlistCubit, WatchlistState>(
                    builder: (context, state) {
                      final isInWatchlist = context
                          .read<WatchlistCubit>()
                          .isInWatchlist(movie.id);
                      return Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (isInWatchlist) {
                              context
                                  .read<WatchlistCubit>()
                                  .removeFromWatchlist(movie.id);
                            } else {
                              context.read<WatchlistCubit>().addToWatchlist(
                                movie,
                              );
                            }
                          },
                          icon: Icon(
                            isInWatchlist
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                          label: Text(
                            isInWatchlist
                                ? 'Remove from Watchlist'
                                : 'Add to Watchlist',
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
