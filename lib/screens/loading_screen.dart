import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determinePosition();

  }


  void determinePosition() async {

    // WeatherModel weatherModel = WeatherModel();
    var weatherData =await WeatherModel().getLocationWeather();

   // print(weatherData);
    nextPage(weatherData);
    // await navigatorKey.currentState!.push(
    //   MaterialPageRoute(builder: (context) {
    //     return const LocationScreen();
    //   }),
    // );

  //
  // await Navigator.push(context, MaterialPageRoute(builder: (context){
  //     return const LocationScreen();
  //   }));
  }
  void nextPage(weatherData){
 //   var data = weatherData;
     Navigator.push(context, MaterialPageRoute(builder: (context){
        return LocationScreen(locationWeather: weatherData);
      }));
  }
  /*
    Don't use 'BuildContext's across async gaps. (Documentation)  Try rewriting the code to not reference the 'BuildContext'.
     */
  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  //   print('deactivated');
  // }

  @override
  Widget build(BuildContext context) {
    // getData();
    return const Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.orange,
        size: 100.0,

      )
    );
  }
}
