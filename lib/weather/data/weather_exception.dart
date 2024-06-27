sealed class WeatherException implements Exception {}

class InvalidParameterException extends WeatherException {}

class UnknownException extends WeatherException {}

class InvalidResponseException extends WeatherException {}

class JsonDecodeException extends WeatherException {}
