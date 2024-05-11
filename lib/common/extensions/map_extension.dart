extension MapExtension on Map<String, dynamic> {
  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      this[key] = value;
    }
  }
}
