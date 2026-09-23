import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
        voteCount,
        numberOfSeasons,
        numberOfEpisodes,
      ];
}