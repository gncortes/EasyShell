import 'package:flutter/material.dart';

enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

abstract class ShimmerWidget extends StatefulWidget {
  final EdgeInsetsGeometry shimmerMargin;
  final Color baseColor;
  final List<Color> gradientColors;
  final Duration duration;
  final ShimmerDirection direction;

  const ShimmerWidget({
    super.key,
    required this.shimmerMargin,
    required this.baseColor,
    required this.gradientColors,
    required this.duration,
    required this.direction,
  });

  factory ShimmerWidget.card({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required Size size,
    required BorderRadiusGeometry radius,
  }) {
    return _ShimmerCard(
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

  factory ShimmerWidget.circle({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required double radius,
  }) {
    return _ShimmerCircle(
      key: key,
      shimmerMargin: shimmerMargin,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      radius: radius,
    );
  }

  factory ShimmerWidget.cardWithChild({
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
    return _ShimmerCardWithChild(
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

  factory ShimmerWidget.circleWithChild({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    required ShimmerDirection direction,
    required Widget child,
    required double radius,
  }) {
    return _ShimmerCircleWithChild(
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

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * slidePercent * 2 - bounds.width,
      0.0,
      0.0,
    );
  }
}

mixin _AnimationControllerMixin on State<ShimmerWidget> {
  late AnimationController _controller;

  AnimationController get animationController => _controller;

  Duration get animationDuration;

  TickerProvider get ticker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: ticker,
      duration: animationDuration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant ShimmerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.duration != animationDuration) {
      _controller.stop();
      _controller.dispose();
      _controller = AnimationController(
        vsync: ticker,
        duration: animationDuration,
      )..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ShimmerGradient {
  final ShimmerDirection direction;
  final List<Color> colors;
  final double slidePercent;

  _ShimmerGradient({
    required this.direction,
    required this.colors,
    required this.slidePercent,
  });

  Shader createShader(Rect bounds) {
    final Alignment begin;
    final Alignment end;

    switch (direction) {
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
      colors: colors,
      stops: const [0.1, 0.5, 0.9],
      transform: _SlidingGradientTransform(slidePercent: slidePercent),
    ).createShader(bounds);
  }
}

class _ShimmerCard extends ShimmerWidget {
  final Size size;
  final BorderRadiusGeometry radius;

  const _ShimmerCard({
    super.key,
    required this.size,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCardState(
        size: size,
        radius: radius,
      );
}

class _ShimmerCardState extends State<ShimmerWidget>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  final Size size;
  final BorderRadiusGeometry radius;

  _ShimmerCardState({
    required this.size,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (value) => _ShimmerGradient(
              colors: widget.gradientColors,
              direction: widget.direction,
              slidePercent: animationController.value,
            ).createShader(value),
            blendMode: BlendMode.srcATop,
            child: Container(
              decoration: BoxDecoration(
                color: widget.baseColor.withOpacity(0.1),
                borderRadius: radius,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
}

class _ShimmerCardWithChild extends ShimmerWidget {
  final Widget child;
  final Size size;
  final BorderRadiusGeometry radius;

  const _ShimmerCardWithChild({
    super.key,
    required this.child,
    required this.size,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCardWithChildState(
        child: child,
        size: size,
        radius: radius,
      );
}

class _ShimmerCardWithChildState extends State<ShimmerWidget>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  final Widget child;
  final Size size;
  final BorderRadiusGeometry radius;

  _ShimmerCardWithChildState({
    required this.child,
    required this.size,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: widget.baseColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (value) => _ShimmerGradient(
                  colors: widget.gradientColors,
                  direction: widget.direction,
                  slidePercent: animationController.value,
                ).createShader(value),
                blendMode: BlendMode.srcATop,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.baseColor.withOpacity(0.1),
                    borderRadius: radius,
                  ),
                ),
              );
            },
          ),
          child,
        ],
      ),
    );
  }

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
}

class _ShimmerCircle extends ShimmerWidget {
  final double radius;

  const _ShimmerCircle({
    super.key,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCircleState(radius: radius);
}

class _ShimmerCircleState extends State<ShimmerWidget>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  final double radius;

  _ShimmerCircleState({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (value) => _ShimmerGradient(
              colors: widget.gradientColors,
              direction: widget.direction,
              slidePercent: animationController.value,
            ).createShader(value),
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

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
}

class _ShimmerCircleWithChild extends ShimmerWidget {
  final Widget child;
  final double radius;

  const _ShimmerCircleWithChild({
    super.key,
    required this.child,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCircleWithChildState(
        child: child,
        radius: radius,
      );
}

class _ShimmerCircleWithChildState extends State<ShimmerWidget>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  final Widget child;
  final double radius;

  _ShimmerCircleWithChildState({
    required this.child,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
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
                shaderCallback: (value) => _ShimmerGradient(
                  colors: widget.gradientColors,
                  direction: widget.direction,
                  slidePercent: animationController.value,
                ).createShader(value),
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
          child,
        ],
      ),
    );
  }

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
}
