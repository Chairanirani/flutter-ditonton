import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  group('get Airing Today TV Series', () {
    final tTvList = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/airing_today.json'))
          as Map<String, dynamic>,
    ).tvSeriesList;

    test('should return list of TV Series when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/airing_today.json'), 200),
          );

      // act
      final result = await dataSource.getAiringTodayTvSeries();

      // assert
      expect(result, equals(tTvList));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arange
        when(
          mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getAiringTodayTvSeries();

        // assert
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
}
