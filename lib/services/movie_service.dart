//Packages
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

//Models
import '../models/movie.dart';
import 'http_services.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late final HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final Response? response = await _http.get(
      '/movie/popular',
      query: {'page': page},
    );

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> results = data['results'] ?? [];
      return results.map<Movie>((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception(
        'Couldn\'t load popular movies. Code: ${response?.statusCode}',
      );
    }
  }

  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    final Response? response = await _http.get(
      '/movie/upcoming',
      query: {'page': page},
    );

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> results = data['results'] ?? [];
      return results.map<Movie>((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception(
        'Couldn\'t load upcoming movies. Code: ${response?.statusCode}',
      );
    }
  }

  Future<List<Movie>> searchMovies(String searchTerm, {int page = 1}) async {
    if (searchTerm.trim().isEmpty) return [];

    final Response? response = await _http.get(
      '/search/movie',
      query: {'query': searchTerm, 'page': page, 'include_adult': false},
    );

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final List<dynamic> results = data['results'] ?? [];
      return results.map<Movie>((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception(
        'Couldn\'t perform movie search. Code: ${response?.statusCode}',
      );
    }
  }
}
