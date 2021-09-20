import 'package:equatable/equatable.dart';

// we use event to for triggering or for the input.
class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//fetching weather
class GetWeatherFromSearch extends WeatherEvent {
  final String city;

  GetWeatherFromSearch(this.city);

  @override
  List<Object?> get props => [city];
}

//reset weather(searching another city by this event)
class RefreshWeather extends WeatherEvent {}
