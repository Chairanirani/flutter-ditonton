import 'package:flutter/foundation.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier({required this.searchTvSeries});

  var _searchResult = <TvSeries>[];
  List<TvSeries> get searchResult => _searchResult;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _searchResult = data;
        notifyListeners();
      },
    );
  }
}