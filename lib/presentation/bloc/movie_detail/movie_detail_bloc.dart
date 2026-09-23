import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<AddWatchlist>(_onAddWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(
      event.id,
    );
    final watchlistStatus = await getWatchListStatus.execute(event.id);

    detailResult.fold((failure) => emit(MovieDetailError(failure.message)), (
      movieDetail,
    ) {
      recommendationResult.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (movieRecommendationsList) {
          emit(
            MovieDetailHasData(
              movie: movieDetail,
              recommendations: movieRecommendationsList,
              isAddedToWatchlist: watchlistStatus,
            ),
          );
        },
      );
    });
  }

  Future<void> _onAddWatchlist(
    AddWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movie);
    final status = await getWatchListStatus.execute(event.movie.id);

    result.fold(
      (failure) {
        if (state is MovieDetailHasData) {
          emit(
            (state as MovieDetailHasData).copyWith(
              watchlistMessage: failure.message,
              isAddedToWatchlist: status,
            ),
          );
        }
      },
      (successMessage) {
        if (state is MovieDetailHasData) {
          emit(
            (state as MovieDetailHasData).copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: status,
            ),
          );
        }
      },
    );
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movie);
    final status = await getWatchListStatus.execute(event.movie.id);

    result.fold(
      (failure) {
        if (state is MovieDetailHasData) {
          emit(
            (state as MovieDetailHasData).copyWith(
              watchlistMessage: failure.message,
              isAddedToWatchlist: status,
            ),
          );
        }
      },
      (successMessage) {
        if (state is MovieDetailHasData) {
          emit(
            (state as MovieDetailHasData).copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: status,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<MovieDetailState> emit,
  ) async {
    final status = await getWatchListStatus.execute(event.id);
    if (state is MovieDetailHasData) {
      emit((state as MovieDetailHasData).copyWith(isAddedToWatchlist: status));
    }
  }
}
