import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/utils/storage.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingInitial()) {
    on<LoadingEvent>((event, emit) {
      if (event is GetStatus) {
        if (Storage.getCountry() == "") {
          emit(const CountryNotSet());
        } else {
          emit(const CountrySet());
        }
      }
    });
  }
}
