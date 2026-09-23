import 'package:flutter/foundation.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = data;
        notifyListeners();
      },
    );
  }
}