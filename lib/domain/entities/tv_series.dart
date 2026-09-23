import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  TvSeries({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    genreIds,
    id,
    overview,
    popularity,
    posterPath,
    name,
    voteAverage,
    voteCount,
  ];

  TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  }) : backdropPath = null,
      genreIds = null,
      popularity = null,
      voteAverage = null,
      voteCount = null;
}