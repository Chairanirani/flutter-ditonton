import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  TvSeriesModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? name;
  final double? voteAverage;
  final int? voteCount;
  final String? firstAirDate;

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    firstAirDate: json['first_air_date'],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeries toEntity() => TvSeries(
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    name: name,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

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
}
