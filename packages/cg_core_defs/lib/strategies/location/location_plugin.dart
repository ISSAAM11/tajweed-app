abstract class LocationPlugin {
  /// Checks if the app has permission to access location.
  Future<bool> hasPermission();

  /// Requests permission to access location.
  Future<bool> requestPermission();

  /// Checks if the location service is enabled.
  Future<bool> serviceEnabled();

  /// Request the activation of the location service.
  Future<bool> requestService();

  /// Gets the current location of the user.
  Future<GeoCoordinates> getLocation();

  /// Opens the App settings page.
  Future<bool> openAppSettings();

  /// Opens the location settings page.
  Future<bool> openLocationSettings();

  // @override
  // Stream<LocationData> get onLocationChanged;
}

class GeoCoordinates {
  final double latitude;
  final double longitude;

  const GeoCoordinates(double latitude, double longitude)
      : latitude = latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        // Avoids normalization if possible to prevent unnecessary loss of precision
        longitude = longitude >= -180 && longitude < 180 ? longitude : (longitude + 180.0) % 360.0 - 180.0;
}
