import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
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
  final List<GenreModel> genres;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        name: json["name"] ?? json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        numberOfSeasons: json["number_of_seasons"] ?? 0,
        numberOfEpisodes: json["number_of_episodes"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "number_of_seasons": numberOfSeasons,
        "number_of_episodes": numberOfEpisodes,
      };

  TvSeriesDetail toEntity() => TvSeriesDetail(
        backdropPath: backdropPath,
        genres: genres.map((genre) => genre.toEntity()).toList(),
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        numberOfSeasons: numberOfSeasons,
        numberOfEpisodes: numberOfEpisodes,
      );

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