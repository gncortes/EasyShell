import 'package:flutter/material.dart';

enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

class Shimmer extends StatefulWidget {
  const Shimmer._({super.key});

  @override
  State<Shimmer> createState() => throw UnimplementedError();

  /// Factory to create a Shimmer Card.
  factory Shimmer.card({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required Size size,
    required BorderRadiusGeometry radius,
  }) {
    return ShimmerCard(
      key: key,
      shimmerMargin: shimmerMargin,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      size: size,
      radius: radius,
    );
  }

  /// Factory to create a Shimmer Circle.
  factory Shimmer.circle({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required double radius,
  }) {
    return ShimmerCircle(
      key: key,
      shimmerMargin: shimmerMargin,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      radius: radius,
    );
  }

  factory Shimmer.row({
    Key? key,
    required List<Shimmer> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return ShimmerRow(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

class ShimmerRow extends Shimmer {
  final List<Shimmer> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  const ShimmerRow({
    super.key,
    required this.children,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
  }) : super._();

  @override
  State<ShimmerRow> createState() => _ShimmerRowState();
}

class _ShimmerRowState extends State<ShimmerRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: widget.mainAxisSize,
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.children,
    );
  }
}

class ShimmerCard extends Shimmer {
  final EdgeInsetsGeometry shimmerMargin;
  final Color baseColor;
  final List<Color> gradientColors;
  final Duration duration;
  final ShimmerDirection direction;
  final Size size;
  final BorderRadiusGeometry radius;
  const ShimmerCard({
    super.key,
    required this.shimmerMargin,
    required this.baseColor,
    required this.gradientColors,
    required this.duration,
    required this.direction,
    required this.size,
    required this.radius,
  }) : super._();

  @override
  State<ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: widget.radius,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              Alignment begin;
              Alignment end;

              switch (widget.direction) {
                case ShimmerDirection.leftToRight:
                  begin = const Alignment(-1.0, 0.0);
                  end = const Alignment(1.0, 0.0);
                  break;
                case ShimmerDirection.rightToLeft:
                  begin = const Alignment(1.0, 0.0);
                  end = const Alignment(-1.0, 0.0);
                  break;
                case ShimmerDirection.topToBottom:
                  begin = const Alignment(0.0, -1.0);
                  end = const Alignment(0.0, 1.0);
                  break;
                case ShimmerDirection.bottomToTop:
                  begin = const Alignment(0.0, 1.0);
                  end = const Alignment(0.0, -1.0);
                  break;
              }

              return LinearGradient(
                begin: begin,
                end: end,
                colors: widget.gradientColors,
                stops: const [0.1, 0.5, 0.9],
                transform: _SlidingGradientTransform(
                  slidePercent: _controller.value,
                ),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Container(
              decoration: BoxDecoration(
                color: widget.baseColor.withOpacity(0.1),
                borderRadius: widget.radius,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerCircle extends Shimmer {
  final EdgeInsetsGeometry shimmerMargin;
  final Color baseColor;
  final List<Color> gradientColors;
  final Duration duration;
  final ShimmerDirection direction;
  final double radius;
  const ShimmerCircle({
    super.key,
    required this.shimmerMargin,
    required this.baseColor,
    required this.gradientColors,
    required this.duration,
    required this.direction,
    required this.radius,
  }) : super._();

  @override
  State<ShimmerCircle> createState() => _ShimmerCircleState();
}

class _ShimmerCircleState extends State<ShimmerCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.radius * 2,
      width: widget.radius * 2,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              Alignment begin;
              Alignment end;

              switch (widget.direction) {
                case ShimmerDirection.leftToRight:
                  begin = const Alignment(-1.0, 0.0);
                  end = const Alignment(1.0, 0.0);
                  break;
                case ShimmerDirection.rightToLeft:
                  begin = const Alignment(1.0, 0.0);
                  end = const Alignment(-1.0, 0.0);
                  break;
                case ShimmerDirection.topToBottom:
                  begin = const Alignment(0.0, -1.0);
                  end = const Alignment(0.0, 1.0);
                  break;
                case ShimmerDirection.bottomToTop:
                  begin = const Alignment(0.0, 1.0);
                  end = const Alignment(0.0, -1.0);
                  break;
              }

              return LinearGradient(
                begin: begin,
                end: end,
                colors: widget.gradientColors,
                stops: const [0.1, 0.5, 0.9],
                transform: _SlidingGradientTransform(
                  slidePercent: _controller.value,
                ),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Container(
              decoration: BoxDecoration(
                color: widget.baseColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * slidePercent * 2 - bounds.width,
      bounds.height * slidePercent * 2 - bounds.height,
      0.0,
    );
  }
}
