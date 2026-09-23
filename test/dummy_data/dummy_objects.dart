import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/movie.dart';

final testTvSeries = TvSeries(
  backdropPath: '/muth4OYamixd413cH9PgQXw3JUV.jpg',
  genreIds: [18, 80],
  id: 1396,
  overview: 'When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer...',
  popularity: 326.5,
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  voteAverage: 8.9,
  voteCount: 12000,
  name: 'Breaking Bad',
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: '/muth4OYamixd413cH9PgQXw3JUV.jpg',
  genres: [Genre(id: 18, name: 'Drama')],
  id: 1396,
  overview: 'When Walter White, a New Mexico chemistry teacher...',
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  name: 'Breaking Bad',
  voteAverage: 8.9,
  voteCount: 12000,
  numberOfSeasons: 5,
  numberOfEpisodes: 62,
);

final testTvSeriesModel = TvSeriesModel(
  backdropPath: '/muth4OYamixd413cH9PgQXw3JUV.jpg',
  genreIds: [18, 80],
  id: 1396,
  overview: 'When Walter White, a New Mexico chemistry teacher...',
  popularity: 326.5,
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  voteAverage: 8.9,
  voteCount: 12000,
  name: 'Breaking Bad',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};