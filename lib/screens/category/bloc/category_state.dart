part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryNewsLoading extends CategoryState {
  const CategoryNewsLoading();
}

class CategoryNewsLoaded extends CategoryState {
  const CategoryNewsLoaded(this.news);

  final News news;
}

class CategoryNewsEmpty extends CategoryState {
  const CategoryNewsEmpty();
}

class CategoryNewsError extends CategoryState {
  const CategoryNewsError();
}
