import 'package:flutter/material.dart';
import 'package:tabib_app/core/extension/app_extension.dart';

class StarReview extends StatelessWidget {
  final double rating;

  const StarReview({super.key, this.rating = 0});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final filled = rating.round().clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isFilled = index < filled;
        return Icon(
          isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 14,
          color: isFilled ? theme.primaryColor : theme.textColor100,
        );
      }),
    );
  }
}
