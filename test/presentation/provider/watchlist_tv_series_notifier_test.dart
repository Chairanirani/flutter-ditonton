import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_notifier_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesNotifier notifier;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    notifier = WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when watchlist is called', () async {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([testTvSeries]));
    // act
    notifier.fetchWatchlistTvSeries();
    // assert
    expect(notifier.watchlistState, RequestState.Loading);
  });

  test('should change watchlist data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([testTvSeries]));
    // act
    await notifier.fetchWatchlistTvSeries();
    // assert
    expect(notifier.watchlistState, RequestState.Loaded);
    expect(notifier.watchlistTvSeries, [testTvSeries]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure('Can\'t get data')));
    // act
    await notifier.fetchWatchlistTvSeries();
    // assert
    expect(notifier.watchlistState, RequestState.Error);
    expect(notifier.message, 'Can\'t get data');
    expect(listenerCallCount, 2);
  });
}