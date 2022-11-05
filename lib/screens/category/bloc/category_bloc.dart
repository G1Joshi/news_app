import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late NewsAPI api;
  late News news;

  CategoryBloc() : super(const CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      api = NewsAPI();

      if (event is GetCategoryNews) {
        emit(const CategoryNewsLoading());
        try {
          news = await api.getCategoryNews(event.category);
          news.totalResults == 0
              ? emit(const CategoryNewsEmpty())
              : emit(CategoryNewsLoaded(news));
        } catch (e) {
          emit(const CategoryNewsError());
        }
      }
    });
  }
}
