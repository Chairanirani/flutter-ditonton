import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchNotifier notifier;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    notifier = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
    backdropPath: '/backdrop.jpg',
    genreIds: [1, 2],
    id: 1,
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/poster.jpg',
    voteAverage: 1.0,
    voteCount: 1,
    name: 'Name',
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];
  final tQuery = 'spider';

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery))
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchTvSeriesSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change search result data when data is gotten successfully', () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery))
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchTvSeriesSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockSearchTvSeries.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSeriesSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}