import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

@GenerateMocks([MovieDetailBloc]) // Opsional jika pakai GenerateMocks, tapi MockBloc dari bloc_test lebih praktis
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(home: body),
    );
  }

  final testHasData = MovieDetailHasData(
    movie: testMovieDetail,
    recommendations: <Movie>[],
    isAddedToWatchlist: false,
  );

  final testHasDataWatchlisted = MovieDetailHasData(
    movie: testMovieDetail,
    recommendations: <Movie>[],
    isAddedToWatchlist: true,
  );

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      whenListen(
        mockMovieDetailBloc,
        Stream.value(testHasData),
        initialState: testHasData,
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);
      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when movie is added to watchlist',
    (WidgetTester tester) async {
      whenListen(
        mockMovieDetailBloc,
        Stream.value(testHasDataWatchlisted),
        initialState: testHasDataWatchlisted,
      );
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      final loadedStateWithMsg = testHasData.copyWith(
        watchlistMessage: 'Added to Watchlist',
      );

      whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([loadedStateWithMsg]),
        initialState: testHasData,
      );

      final watchlistButton = find.byType(FilledButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      final loadedStateWithMsg = testHasData.copyWith(
        watchlistMessage: 'Failed',
      );

      whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([loadedStateWithMsg]),
        initialState: testHasData,
      );

      final watchlistButton = find.byType(FilledButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
