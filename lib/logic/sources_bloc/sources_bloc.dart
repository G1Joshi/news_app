import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/models/source_model.dart';
import 'package:news_app/data/services/source_api.dart';

part 'sources_event.dart';
part 'sources_state.dart';

class SourcesBloc extends Bloc<SourcesEvent, SourcesState> {
  late SourcesAPI api;
  late Sources sources;

  SourcesBloc() : super(const SourcesInitial()) {
    on<SourcesEvent>((event, emit) async {
      api = SourcesAPI();

      if (event is GetSources) {
        emit(const SourcesLoading());
        try {
          sources = await api.getSources();
          emit(SourcesLoaded(sources));
        } catch (e) {
          emit(const SourcesError());
        }
      }
    });
  }
}
