import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

abstract class Geocoder {
  Future<Placemark> decodeAddress(String address);
}

class GeolocatorGeocoder extends Geocoder {
  @override
  Future<Placemark> decodeAddress(String address) async{
    List<Placemark> placemarks = await Geolocator()
          .placemarkFromAddress("$address, Lodz", localeIdentifier: "pl_PL");

    return placemarks.first;
  }
}