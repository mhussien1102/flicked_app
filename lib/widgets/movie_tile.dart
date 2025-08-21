import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final double height;
  final double width;
  final Movie movie;

  const MovieTile({
    super.key,
    required this.movie,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _poster(),
          const SizedBox(width: 12),
          // Constrain the right side so it doesn't overflow
          Expanded(child: _info()),
        ],
      ),
    );
  }

  Widget _poster() {
    return SizedBox(
      // keep poster narrow and consistent
      width: width * 0.33,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 2 / 3, // typical movie poster
          child: Image.network(
            movie.posterURL(),
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) => Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.white54),
                ),
          ),
        ),
      ),
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + rating row, both constrained
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                movie.name ?? "No title",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              movie.rating!.toStringAsFixed(1),
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${movie.language!.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        // Make the description take remaining height but never overflow
        Expanded(
          child: Text(
            movie.description ?? 'No description',
            maxLines: 6, // adjust to your tile height
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
