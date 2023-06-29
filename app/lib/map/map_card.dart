import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  const MapCard({
    super.key,
    required this.label,
    required this.child,
    this.onClose,
  });

  final String label;
  final Widget child;

  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).extension<MapCardTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(theme.borderRadius),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                )
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class MapCardTheme extends ThemeExtension<MapCardTheme> {
  const MapCardTheme({required this.borderRadius});

  final double borderRadius;

  @override
  ThemeExtension<MapCardTheme> copyWith({double? borderRadius}) {
    return MapCardTheme(borderRadius: borderRadius ?? this.borderRadius);
  }

  @override
  ThemeExtension<MapCardTheme> lerp(
      covariant ThemeExtension<MapCardTheme>? other, double t) {
    return MapCardTheme(borderRadius: borderRadius);
  }
}
