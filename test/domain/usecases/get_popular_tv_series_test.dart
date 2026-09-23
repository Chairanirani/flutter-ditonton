import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriesList = <TvSeries>[];
  final tId = 1;

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getPopularTvSeries())
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvSeriesList));
    verify(mockTvSeriesRepository.getPopularTvSeries());
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
