import 'package:equatable/equatable.dart';
import 'package:flutter_weather_bloc/weather.dart';

class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

// when weather not search, means UI should be shown
class WeatherNotSearchState extends WeatherState {}

//when weather is loading == shows circular indicator
class WeatherIsSearchingState extends WeatherState {}

//when wearther is loaded, API weather should be displayed
class WeatherIsSearchedState extends WeatherState {
  final weather;
  WeatherIsSearchedState(this.weather);
  //created weather getter
  Weather get getWeather => weather;

  @override
  List<Object?> get props => [weather];
}

class WeatherIsNotLoaded extends WeatherState {}
