import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/Data/model/movie_model.dart';

class MovieService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'YOUR_API_KEY_HERE'; // Add your TMDB API key

  Future<MovieResponse> getNowPlaying({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> getUpcoming({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> getTopRated({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> getPopular({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieResponse> searchMovies(String query, {int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page'),
    );

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search movies');
    }
  }
}