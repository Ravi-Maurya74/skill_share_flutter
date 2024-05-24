import 'package:flutter/material.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your logic here
      },
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
