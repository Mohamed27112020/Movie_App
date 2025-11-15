import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Data/model/movie_model.dart';
import 'package:movie_app/Views/detailsmovie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
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
}
