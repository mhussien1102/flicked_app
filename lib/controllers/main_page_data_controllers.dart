import 'package:flicked_app/models/main_page_data.dart';
import 'package:flicked_app/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../models/movie.dart';

class MainPageDataControllers extends StateNotifier<MainPageData> {
  MainPageDataControllers([MainPageData? state])
    : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];
      movies = await movieService.getPopularMovies(state.page);
    } catch (e) {}
  }
}
