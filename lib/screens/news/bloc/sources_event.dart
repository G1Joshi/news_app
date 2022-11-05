part of 'sources_bloc.dart';

abstract class SourcesEvent extends Equatable {
  const SourcesEvent();

  @override
  List<Object> get props => [];
}

class GetSources extends SourcesEvent {
  const GetSources();
}
