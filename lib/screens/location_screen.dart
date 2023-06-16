import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;
  const LocationScreen({super.key, this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // ignore: prefer_typing_uninitialized_variables
  late var weatherCondition;
  // ignore: prefer_typing_uninitialized_variables
  late var temperatureMsg;
  // ignore: prefer_typing_uninitialized_variables
  late String cityname;
  late int tempInt;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {

      if(weatherData == null){
        tempInt = 0;
        weatherCondition = 'Error';
        cityname = '';
      }


      var condition = weatherData['weather'][0]['id'];
      weatherCondition = weatherModel.getWeatherIcon(condition);
      var temp = weatherData['main']['temp'];
      tempInt = temp.toInt();
      temperatureMsg = weatherModel.getMessage(tempInt);
      cityname = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.webp'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                     var typeName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const CityScreen();
                      }));
                      if(typeName != null){
                        var weatherData = await weatherModel.getCityWeather(typeName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$tempInt C",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherCondition.toString(),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 45.0),
                child: Text(
                  "$temperatureMsg $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
