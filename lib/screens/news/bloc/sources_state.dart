part of 'sources_bloc.dart';

abstract class SourcesState extends Equatable {
  const SourcesState();

  @override
  List<Object> get props => [];
}

class SourcesInitial extends SourcesState {
  const SourcesInitial();
}

class SourcesLoading extends SourcesState {
  const SourcesLoading();
}

class SourcesLoaded extends SourcesState {
  const SourcesLoaded(this.sources);

  final Sources sources;
}

class SourcesEmpty extends SourcesState {
  const SourcesEmpty();
}

class SourcesError extends SourcesState {
  const SourcesError();
}
