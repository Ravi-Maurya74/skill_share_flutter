
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostLoading extends StatelessWidget {
  const PostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Mimic the title
            Container(
              width: double.infinity,
              height: 24.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            // Mimic the main image
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            // Mimic the text
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

