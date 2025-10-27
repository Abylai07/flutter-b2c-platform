import 'package:dio/dio.dart';

import 'geocoding_model.dart';

class Geocoding {
  static final Geocoding _singleton = Geocoding._internal();
  factory Geocoding() {
    return _singleton;
  }
  Geocoding._internal();

  final Dio _dio = Dio();

  static const mapAPIKey = 'AIzaSyC4ouccl5KDU341JXkGiSig0dLc55pbKRM';
  static const mapAPI = 'https://maps.googleapis.com/maps/api';

  Future<Map<String, dynamic>> fetchAddress(double lat, double lon) async {
    final response = await _dio.get(
        '$mapAPI/geocode/json?language=ru&address=$lat,$lon&latlng=$lat,$lon&location_type=ROOFTOP&result_type=street_address&key=$mapAPIKey');
    if (response.data['results'].isNotEmpty) {
      return response.data['status'] == 'OK'
          ? {
              'description': response.data['results'][0]['formatted_address'],
              'place_id': response.data['results'][0]['place_id'],
            }
          : {};
    } else {
      final response = await _dio.get(
          '$mapAPI/geocode/json?language=ru&address=$lat,$lon&latlng=$lat,$lon&location_type=GEOMETRIC_CENTER&result_type=street_address&key=$mapAPIKey');
      return response.data['status'] == 'OK'
          ? {
              'description': response.data['results'][0]['formatted_address'],
              'place_id': response.data['results'][0]['place_id'],
            }
          : {};
    }
  }

  /// Function return LIST of MAP, where first element['description'] is
  /// address description, and second element['place_id'] is address's place ID
  Future<List<GeocodingModel>> autocomplete(String query) async {
    final response = await _dio.get(
      '$mapAPI/place/autocomplete/json',
      queryParameters: {
        'input': query,
        'location': 'Алматы',
        'radius': 20000,
        'language': 'ru',
        'offset': 3,
        'types': 'geocode',
        'components': 'country:KZ',
        'key': mapAPIKey,
      },
    );
    return response.statusCode == 200
        ? (response.data['predictions'] as List)
            .map((e) => GeocodingModel.fromJson({
                  'description': e['description'],
                  'place_id': e['place_id'],
                }))
            .toList()
        : [];
  }

  Future<String> getPlaceId(String street, String houseNumber) async {
    final response = await _dio.get(
        '$mapAPI/place/findplacefromtext/json?input=$street $houseNumber&inputtype=textquery&fields=place_id&key=$mapAPIKey');

    if (response.statusCode == 200 &&
        response.data['candidates'] != null &&
        response.data['candidates'].isNotEmpty) {
      return response.data['candidates'][0]['place_id'];
    } else {
      return '';
    }
  }

  Future<List<double>> fetchCoordinates(String placeId) async {
    final response = await _dio
        .get('$mapAPI/place/details/json?place_id=$placeId&key=$mapAPIKey');
    print("RESPONSE RSERSES $response");
    return response.statusCode == 200
        ? [
            response.data['result']['geometry']['location']['lat'] as double,
            response.data['result']['geometry']['location']['lng'] as double,
          ]
        : [];
  }
}
