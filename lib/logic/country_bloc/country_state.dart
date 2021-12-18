part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {
  const CountryInitial();
}

class CountrySet extends CountryState {
  const CountrySet();
}

class CountryNotSet extends CountryState {
  const CountryNotSet();
}
