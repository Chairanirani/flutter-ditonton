import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  
  final GetWatchlistTvSeriesStatus getWatchlistStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchlistStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  TvSeriesDetail? _tvSeries;
  TvSeriesDetail? get tvSeries => _tvSeries;
  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  var _recommendations = <TvSeries>[];
  List<TvSeries> get recommendations => _recommendations;
  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _tvSeriesState = RequestState.Loaded;
        _tvSeries = tv;
        notifyListeners();
      },
    );

    recommendationResult.fold(
      (failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvList) {
        _recommendationState = RequestState.Loaded;
        _recommendations = tvList;
        notifyListeners();
      },
    );
  }

  String watchlistMessage = '';

  Future<void> addWatchlist(TvSeriesDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    result.fold(
      (failure) => watchlistMessage = failure.message,
      (successMessage) => watchlistMessage = successMessage,
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    result.fold(
      (failure) => watchlistMessage = failure.message,
      (successMessage) => watchlistMessage = successMessage,
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}