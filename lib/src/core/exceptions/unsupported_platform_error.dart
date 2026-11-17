class UnsupportedPlatformError(final String platform) extends Error {
  @override
  String toString() => 'Unsupported platform: $platform';
}
