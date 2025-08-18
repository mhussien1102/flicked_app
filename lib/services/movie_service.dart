import 'package:dio/dio.dart';
import 'package:flicked_app/services/http_services.dart';
import 'package:get_it/get_it.dart';

import '../models/movie.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPServices http;

  MovieService() {
    http = getIt.get<HTTPServices>();
  }

  Future<List<Movie>> getPopularMovies(int page) async {
    Response? response = await http.get('movie/popular', query: {'page': page});

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies =
          data['results'].map<Movie>((movieData) {
            return Movie.fromJson(movieData);
          }).toList();

      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
