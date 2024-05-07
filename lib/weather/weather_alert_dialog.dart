import 'package:flutter/material.dart';

class WeatherAlertDialog extends StatelessWidget {
  const WeatherAlertDialog({required String errorMessage, super.key})
      : _errorMessage = errorMessage;
  final String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reloading Weather Info Error'),
      content: Text(_errorMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
