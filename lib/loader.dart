import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loader extends StatelessWidget {
  final double? height;
  final double? width;
  final List<Color>? colors;
  final Indicator? indicator;
  const Loader(
      {super.key, this.height, this.width, this.colors, this.indicator});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 50,
        width: width ?? 50,
        child: LoadingIndicator(
            colors: colors ?? [Theme.of(context).colorScheme.background],
            indicatorType: indicator ?? Indicator.circleStrokeSpin),
      ),
    );
  }
}
