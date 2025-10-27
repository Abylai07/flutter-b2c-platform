class GeocodingModel {
  final String description;
  final String placeId;

  GeocodingModel({required this.description, required this.placeId});

  // Factory method to create a Place from a JSON map
  factory GeocodingModel.fromJson(Map<String, dynamic> json) {
    return GeocodingModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }

  // Method to convert a Place to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'place_id': placeId,
    };
  }
}
