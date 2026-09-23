import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  TvSeriesResponse({required this.tvList});

  final List<TvSeriesModel> tvList;

  List<TvSeriesModel> get tvSeriesList => tvList;

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvList: List<TvSeriesModel>.from(
          json["results"]
              .map((x) => TvSeriesModel.fromJson(x))
              .where((element) => element.posterPath != null),
        ),
      );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [tvList];
}
