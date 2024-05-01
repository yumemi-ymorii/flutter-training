enum Screen {
  loading(route: '/loading'),
  weatherScreen(route: '/weather_screen');

  const Screen({
    required this.route,
  });

  final String route;
}
