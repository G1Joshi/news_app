import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/data/services/news_api.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  late NewsAPI api;
  late News news;

  NewsBloc() : super(const NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      api = NewsAPI();

      if (event is GetTopNews) {
        emit(const NewsLoading());
        try {
          news = await api.getTopNews();
          news.totalResults == 0
              ? emit(const NewsEmpty())
              : emit(NewsLoaded(news));
        } catch (e) {
          emit(const NewsError());
        }
      }

      if (event is GetSortedNews) {
        emit(const NewsLoading());
        try {
          news = await api.getSortedNews();
          news.totalResults == 0
              ? emit(const NewsEmpty())
              : emit(NewsLoaded(news));
        } catch (e) {
          emit(const NewsError());
        }
      }

      if (event is GetQueryNews) {
        emit(const NewsLoading());
        try {
          news = await api.getQueryNews(event.query);
          news.totalResults == 0
              ? emit(const NewsEmpty())
              : emit(NewsLoaded(news));
        } catch (e) {
          emit(const NewsError());
        }
      }

      if (event is GetSourceNews) {
        emit(const NewsLoading());
        try {
          news = await api.getSourceNews(event.source);
          news.totalResults == 0
              ? emit(const NewsEmpty())
              : emit(NewsLoaded(news));
        } catch (e) {
          emit(const NewsError());
        }
      }
    });
  }
}
