import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String message;

  const FailureWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.red[700],
      ),
    );
  }
}
