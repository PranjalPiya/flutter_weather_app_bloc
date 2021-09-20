import 'package:equatable/equatable.dart';
import 'package:flutter_weather_bloc/weather.dart';

// we use state in bloc for the output.
class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

// when weather not search, means UI should be shown
class WeatherNotSearchState extends WeatherState {}

//when weather is loading == shows circular indicator
class WeatherIsSearchingState extends WeatherState {}

//when weather is loaded, data should be displayed
class WeatherIsSearchedState extends WeatherState {
  final Weather? weather;
  WeatherIsSearchedState({this.weather});

  // Weather get getWeather => weather;

  @override
  List<Object?> get props => [weather];
}

//when weather is not loaded.
class WeatherNotLoaded extends WeatherState {}
