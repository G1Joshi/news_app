part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetTopNews extends NewsEvent {
  const GetTopNews();
}

class GetSortedNews extends NewsEvent {
  const GetSortedNews(this.sort);

  final String sort;
}

class GetQueryNews extends NewsEvent {
  const GetQueryNews(this.query);

  final String query;
}

class GetSourceNews extends NewsEvent {
  const GetSourceNews(this.source);

  final String source;
}
