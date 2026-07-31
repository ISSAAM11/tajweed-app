import 'package:cg_core_defs/strategies/location/location_plugin.dart';
import 'package:equatable/equatable.dart';

class PlaceDetail with EquatableMixin {
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? placeId;
  final int utcOffset;

  GeoCoordinates get location => GeoCoordinates(latitude ?? 0, longitude ?? 0);

  const PlaceDetail({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
    this.placeId,
    this.utcOffset = 0,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> json) => PlaceDetail(
        address: json['address'] as String?,
        latitude: json['lat'] as double?,
        longitude: json['lat'] as double?,
        name: json['name'] as String?,
        placeId: json['placeId'] as String?,
        utcOffset: json['utcOffset'] as int? ?? 0,
      );

  Map<String, dynamic> toJosn() => {
        'lat': latitude,
        'lng': longitude,
        'address': address,
        'placeId': placeId,
        'utcOffset': utcOffset,
      };

  @override
  List<Object?> get props => [latitude, longitude, address];
}
