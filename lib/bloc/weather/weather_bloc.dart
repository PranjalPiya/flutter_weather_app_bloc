import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather/weather_event.dart';
import 'package:flutter_weather_bloc/bloc/weather/weather_state.dart';
import 'package:flutter_weather_bloc/fetch_weather.dart';
import 'package:flutter_weather_bloc/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherBloc(WeatherNotSearchState weatherNotSearchState)
      : super(WeatherNotSearchState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    //another example
    if (event is GetWeatherFromSearch) {
      yield WeatherIsSearchingState();
      try {
        Weather? weather =
            await Fetch.weatherData(cityWeather: "${event.city}");
        yield WeatherIsSearchedState(weather);
      } catch (_) {
        yield WeatherNotSearchState();
      }
    }

    // if (event is GetWeatherFromSearch) {
    //   yield* mapWeatherFromSearch(event);
    // }

    if (event is RefreshWeather) {
      yield WeatherNotSearchState();
    }
  }

  //Weather is searched
  // Stream<WeatherState> mapWeatherFromSearch(
  //     GetWeatherFromSearch getWeatherFromSearch) async* {
  //   Weather? weather = await Fetch.weatherData();
  //   yield WeatherIsSearchedState(weather);
  // }
}
