import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  final String title;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            // animationDuration: const Duration(milliseconds: 500),
            backgroundColor: const Color.fromRGBO(3, 65, 114, 1),
            padding: EdgeInsets.zero,
            shape: const StadiumBorder()),
        child: Text(title));
  }
}
