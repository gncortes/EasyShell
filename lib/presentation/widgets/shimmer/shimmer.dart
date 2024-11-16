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

  factory ShimmerWidget.circle({
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

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
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
  void didUpdateWidget(covariant ShimmerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.dispose();
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

  Shader createShader(Rect bounds) {
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
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class ShimmerCard extends ShimmerWidget {
  final Size size;
  final BorderRadiusGeometry radius;

  const ShimmerCard({
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
  State<ShimmerWidget> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends _ShimmerWidgetState {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget as ShimmerCard).size.height,
      width: (widget as ShimmerCard).size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: (widget as ShimmerCard).radius,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: createShader,
            blendMode: BlendMode.srcATop,
            child: Container(
              decoration: BoxDecoration(
                color: widget.baseColor.withOpacity(0.1),
                borderRadius: (widget as ShimmerCard).radius,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerCircle extends ShimmerWidget {
  final double radius;

  const ShimmerCircle({
    super.key,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCircleState();
}

class _ShimmerCircleState extends _ShimmerWidgetState {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget as ShimmerCircle).radius * 2,
      width: (widget as ShimmerCircle).radius * 2,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.baseColor,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: createShader,
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

class ShimmerCardWithChild extends ShimmerWidget {
  final Widget child;
  final Size size;
  final BorderRadiusGeometry radius;

  const ShimmerCardWithChild({
    super.key,
    required this.child,
    required this.size,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
    required this.radius,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCardWithChildState();
}

class _ShimmerCardWithChildState extends _ShimmerWidgetState {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget as ShimmerCardWithChild).size.height,
      width: (widget as ShimmerCardWithChild).size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: (widget as ShimmerCardWithChild).radius,
        color: widget.baseColor,
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: createShader,
                blendMode: BlendMode.srcATop,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.baseColor.withOpacity(0.1),
                    borderRadius: (widget as ShimmerCardWithChild).radius,
                  ),
                ),
              );
            },
          ),
          (widget as ShimmerCardWithChild).child,
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
    required super.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerCircleWithChildState();
}

class _ShimmerCircleWithChildState extends _ShimmerWidgetState {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget as ShimmerCircleWithChild).radius * 2,
      width: (widget as ShimmerCircleWithChild).radius * 2,
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
                shaderCallback: createShader,
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
          (widget as ShimmerCircleWithChild).child,
        ],
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
