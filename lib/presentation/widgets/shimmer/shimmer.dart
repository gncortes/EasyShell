import 'package:flutter/material.dart';

enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

abstract class Shimmer extends StatefulWidget {
  const Shimmer._({super.key});

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

  factory Shimmer.cardWithChild({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required Widget child,
    required Size size,
    required BorderRadiusGeometry radius,
  }) {
    return ShimmerCardWithChild(
      key: key,
      shimmerMargin: shimmerMargin,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      size: size,
      radius: radius,
      child: child,
    );
  }

  factory Shimmer.circleWithChild({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required Widget child,
    required double radius,
  }) {
    return ShimmerCircleWithChild(
      key: key,
      shimmerMargin: shimmerMargin,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      radius: radius,
      child: child,
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
  void didUpdateWidget(covariant ShimmerCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..repeat();
    }
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
  void didUpdateWidget(covariant ShimmerCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..repeat();
    }
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

class ShimmerCardWithChild extends ShimmerCard {
  final Widget child;

  const ShimmerCardWithChild({
    super.key,
    required this.child,
    required super.size,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
    required super.radius,
  }) : super();

  @override
  State<ShimmerCardWithChild> createState() => _ShimmerChildState();
}

class _ShimmerChildState extends State<ShimmerCardWithChild>
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
  void didUpdateWidget(covariant ShimmerCardWithChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      margin: widget.shimmerMargin,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
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
                  color: widget.baseColor,
                  width: widget.size.width,
                  height: widget.size.height,
                ),
              );
            },
          ),
          widget.child,
        ],
      ),
    );
  }
}

class ShimmerCircleWithChild extends ShimmerCircle {
  final Widget child;

  const ShimmerCircleWithChild({
    super.key,
    required this.child,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
    required super.radius,
  }) : super();

  @override
  State<ShimmerCircleWithChild> createState() => _ShimmerCircleWithChildState();
}

class _ShimmerCircleWithChildState extends State<ShimmerCircleWithChild>
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
  void didUpdateWidget(covariant ShimmerCircleWithChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..repeat();
    }
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
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
          widget.child,
        ],
      ),
    );
  }
}
