part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetTopNews extends NewsEvent {
  const GetTopNews();
}

class GetSourceNews extends NewsEvent {
  const GetSourceNews(this.source);

  final String source;
}
