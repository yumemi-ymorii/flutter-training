enum Screen {
  launch(route: '/launch'),
  weatherScreen(route: '/weather_screen');

  const Screen({
    required this.route,
  });

  final String route;
}
