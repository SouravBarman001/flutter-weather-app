
import 'package:geolocator/geolocator.dart';



class Location{
  late double latitude;
  late double longitude;

  Future<void> getCurrentPosition() async{
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude.roundToDouble();
    longitude = position.longitude.roundToDouble();
    }
    catch(e){
      print(e);
    }
  }



       // var condition = decodedData['weather'][0]['id'];
       // var temp = decodedData['main']['temp'];
       // String cityname = decodedData['name'];



}