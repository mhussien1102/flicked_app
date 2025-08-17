import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;

  final GetIt getIt = GetIt.instance;
  MovieTile({
    super.key,
    required this.movie,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [moviePosterWidget(movie.posterUrl()), movieInfoWidget()],
      ),
    );
  }

  Widget movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.56,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget moviePosterWidget(String imageUrl) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl)),
      ),
    );
  }
}
