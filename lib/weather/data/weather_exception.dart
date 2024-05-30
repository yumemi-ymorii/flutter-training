sealed class WeatherException implements Exception {}

class InvalidParameterException extends WeatherException {}

class UnkownException extends WeatherException {}
