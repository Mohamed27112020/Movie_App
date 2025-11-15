 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Data/model/movie_model.dart';

class MovieApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
 static const String apiKey = '40ee99745bad32512037b770dc6ac827';
  Future<MovieResponse> getMovies({
    required int page,
    String category = 'popular',
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/movie/$category?api_key=$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieResponse.fromJson(data);
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }

  Future<MovieResponse> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieResponse.fromJson(data);
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }
}
