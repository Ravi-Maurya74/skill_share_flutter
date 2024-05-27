import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget {
  final Function()? onPressed;
  const JoinButton({
    super.key, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFfb542b),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          'Join',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
