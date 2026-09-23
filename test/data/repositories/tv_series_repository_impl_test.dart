import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvModel = TvSeriesModel(
    backdropPath: '/muth4OYamQXd41YSpV5jmgKycF.jpg',
    genreIds: [18, 80],
    id: 1396,
    overview: 'Breaking Bad overview',
    popularity: 300.0,
    posterPath: '/ztkUQFLlC19CCMYHWiY1z3K1ov.jpg',
    firstAirDate: '2008-01-20',
    name: 'Breaking Bad',
    voteAverage: 8.8,
    voteCount: 1200,
  );

  final tTv = TvSeries(
    backdropPath: '/muth4OYamQXd41YSpV5jmgKycF.jpg',
    genreIds: [18, 80],
    id: 1396,
    overview: 'Breaking Bad overview',
    popularity: 300.0,
    posterPath: '/ztkUQFLlC19CCMYHWiY1z3K1ov.jpg',
    name: 'Breaking Bad',
    voteAverage: 8.8,
    voteCount: 1200,
  );

  final tTvModelList = <TvSeriesModel>[tTvModel];
  final tTvList = <TvSeries>[tTv];

  group('Airing Today TV Series', () {
    test('should return remote data when the call to remote data source is succesful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenAnswer((_) async => tTvModelList);

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(ServerException());

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(result, Left(ServerFailure('Failed to connect to the server')));
    });

    test('should return connection failure when device is not connected to internet', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });
}
