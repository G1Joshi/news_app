import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/sharedprefs.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(const CountryInitial()) {
    on<CountryEvent>((event, emit) {
      if (event is GetStatus) {
        if (Preferences.getCountry() == "") {
          emit(const CountryNotSet());
        } else {
          emit(const CountrySet());
        }
      }
    });
  }
}
