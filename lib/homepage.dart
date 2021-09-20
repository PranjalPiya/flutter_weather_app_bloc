import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_bloc/bloc/weather/weather_bloc.dart';
import 'package:flutter_weather_bloc/bloc/weather/weather_event.dart';
import 'package:flutter_weather_bloc/bloc/weather/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formvalid = GlobalKey<FormState>();
  String? cData;
  TextEditingController searchWeather = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              child: BlocProvider(
                create: (context) => WeatherBloc(WeatherNotSearchState()),
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    print('Weather is not search state');
                    print(state);
                    // --------------------------------WeatherNotSearchState-------------------
                    if (state is WeatherNotSearchState) {
                      print(state);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text('Search Weather',
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ))),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              'assets/searchWeather.svg',
                              width: 100,
                              height: 320,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formvalid,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  controller: searchWeather,
                                  textInputAction: TextInputAction.search,
                                  onChanged: (value) {
                                    cData = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the city or country name.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Enter City name'.toUpperCase(),
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade900,
                                elevation: 10,
                                shape: StadiumBorder(),
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 90),
                              ),
                              onPressed: () {
                                if (_formvalid.currentState!.validate()) {
                                  _formvalid.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  if (cData != null || cData!.isNotEmpty) {
                                    context.read<WeatherBloc>().add(
                                        GetWeatherFromSearch(
                                            searchWeather.text));
                                  }
                                }
                              },
                              child: Text('Search'),
                            ),
                          ],
                        ),
                      );
                    }
                    // --------------------------------WeatherIsSearchingState-------------------
                    else if (state is WeatherIsSearchingState) {
                      print("Weather is searching");
                      print(state);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 320),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade100,
                            backgroundColor: Colors.black,
                            strokeWidth: 10,
                          ),
                        ),
                      );
                    }
                    // --------------------------------WeatherIsSearchedState-------------------
                    else if (state is WeatherIsSearchedState) {
                      print("state is searched");
                      print(state);
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${state.weather?.location?.country}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_pin),
                              SizedBox(width: 5),
                              Text(
                                '${state.weather?.location?.name} ',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 50),
                            child: Divider(
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            height: 200,
                            width: 230,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'http:${state.weather?.current?.condition?.icon}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${state.weather?.current?.tempC}° C",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${state.weather?.current?.condition?.text}",
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${state.weather?.location?.localtime}",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                            '${state.weather?.current?.humidity}'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SvgPicture.asset(
                                          'assets/humidity.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Humidity'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                            '${state.weather?.current?.windKph}'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SvgPicture.asset(
                                          'assets/wind.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Wind Flow'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                            '${state.weather?.current?.feelslikeC}° C'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SvgPicture.asset(
                                          'assets/celsius.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('Feels Like'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                              elevation: 10,
                              shape: StadiumBorder(),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 90),
                            ),
                            onPressed: () {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(RefreshWeather());
                            },
                            child: Text(
                              "Search Another City",
                            ),
                          )
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
