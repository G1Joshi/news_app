part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  const NewsLoaded(this.news);

  final News news;
}

class NewsEmpty extends NewsState {
  const NewsEmpty();
}

class NewsError extends NewsState {
  const NewsError();
}
