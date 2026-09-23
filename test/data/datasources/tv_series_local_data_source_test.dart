import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  final tTvTable = TvSeriesTable(
    id: 1396,
    name: 'Breaking Bad',
    posterPath: '/ztkUQFLlC19CCMYHWiY1z3K1ov.jpg',
    overview: 'Breaking Bad overview',
  );

  group('save watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(tTvTable))
            .thenAnswer((_) async => 1);

        // act
        final result = await dataSource.insertWatchlist(tTvTable);

        // assert
        expect(result, 'Added to Watchlist');
      },
    );

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        // arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist((tTvTable)))
            .thenThrow(Exception());

        // act
        final call = dataSource.insertWatchlist(tTvTable);

        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('Get TV Series Detail by Id', () {
    const tId = 1396;

    test('should return TV Series Table detail when id is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => tTvTable.toJson());

      // act
      final result = await dataSource.getTvSeriesById(tId);

      // assert
      expect(result, tTvTable);
    });

    test('should return null when id is not found', () async {
      //  arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      // act
      final result = await dataSource.getTvSeriesById(tId);

      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from databse', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [tTvTable.toJson()]);

      // act
      final result = await dataSource.getWatchlistTvSeries();

      // assert
      expect(result, [tTvTable]);
    });
  });
}
