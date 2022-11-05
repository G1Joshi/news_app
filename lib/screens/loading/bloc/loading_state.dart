part of 'loading_bloc.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadingInitial extends LoadingState {
  const LoadingInitial();
}

class CountrySet extends LoadingState {
  const CountrySet();
}

class CountryNotSet extends LoadingState {
  const CountryNotSet();
}
