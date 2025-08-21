//Packages
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

//Models
import '../models/main_page_data.dart';
import '../models/movie.dart';
import '../models/search_category.dart';

//Services
import '../services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
    : super(state ?? MainPageData.inital()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];

      final searchText = state.searchText ?? '';
      final page = state.page ?? 1;
      final currentMovies = state.movies ?? [];

      if (searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await _movieService.getPopularMovies(page: page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await _movieService.getUpcomingMovies(page: page);
        } else {
          movies = [];
        }
      } else {
        movies = await _movieService.searchMovies(searchText, page: page);
      }

      state = state.copyWith(
        movies: [...currentMovies, ...movies],
        page: page + 1,
      );
    } catch (e, st) {
      print("getMovies error: $e");
      print(st);
    }
  }

  void updateSearchCategory(String? category) {
    try {
      state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: category,
        searchText: '',
      );
      getMovies();
    } catch (e) {
      print("updateSearchCategory error: $e");
    }
  }

  void updateTextSearch(String searchText) {
    try {
      if (searchText.trim().isEmpty) return; // 🚨 prevent 400 Bad Request
      state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: SearchCategory.none,
        searchText: searchText,
      );
      getMovies();
    } catch (e) {
      print("updateTextSearch error: $e");
    }
  }
}
