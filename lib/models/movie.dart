import 'package:get_it/get_it.dart';

import 'app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final num rating;
  final String releaseDate;
  final String backdropPath;

  Movie({
    required this.name,
    required this.language,
    required this.isAdult,
    required this.description,
    required this.posterPath,
    required this.rating,
    required this.releaseDate,
    required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['title'],
      language: json['original_language'],
      isAdult: json['adult'],
      description: json['description'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: json['vote_average'],
      releaseDate: json['release_date'],
    );
  }

  String posterUrl() {
    final AppConfig aooConfig = GetIt.instance.get<AppConfig>();
    return '${aooConfig.BASE_IMAGE_API_URL}${this.posterPath}';
  }
}
