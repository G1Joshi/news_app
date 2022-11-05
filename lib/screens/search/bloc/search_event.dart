part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetQueryNews extends SearchEvent {
  const GetQueryNews(this.query);

  final String query;
}
