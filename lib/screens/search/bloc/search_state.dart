part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchNewsLoading extends SearchState {
  const SearchNewsLoading();
}

class SearchNewsLoaded extends SearchState {
  const SearchNewsLoaded(this.news);

  final News news;
}

class SearchNewsEmpty extends SearchState {
  const SearchNewsEmpty();
}

class SearchNewsError extends SearchState {
  const SearchNewsError();
}
