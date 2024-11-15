import 'package:flutter/material.dart';

enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

class ShimmerItem extends StatefulWidget {
  final Size? shimmerSize;
  final EdgeInsetsGeometry shimmerMargin;
  final double? shimmerRadius;
  final Color baseColor;
  final List<Color> gradientColors;
  final Duration duration;
  final ShimmerDirection direction;
  final double? radius;

  const ShimmerItem._({
    super.key,
    this.shimmerSize,
    required this.shimmerMargin,
    this.shimmerRadius,
    required this.baseColor,
    required this.gradientColors,
    required this.duration,
    this.direction = ShimmerDirection.leftToRight,
    this.radius,
  });

  factory ShimmerItem.card({
    Key? key,
    required Size shimmerSize,
    required EdgeInsetsGeometry shimmerMargin,
    required double shimmerRadius,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    ShimmerDirection direction = ShimmerDirection.leftToRight,
  }) {
    return ShimmerItem._(
      key: key,
      shimmerSize: shimmerSize,
      shimmerMargin: shimmerMargin,
      shimmerRadius: shimmerRadius,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      radius: null,
    );
  }

  factory ShimmerItem.circle({
    Key? key,
    required EdgeInsetsGeometry shimmerMargin,
    required double radius,
    required Color baseColor,
    required List<Color> gradientColors,
    required Duration duration,
    ShimmerDirection direction = ShimmerDirection.leftToRight,
  }) {
    return ShimmerItem._(
      key: key,
      shimmerSize: null,
      shimmerMargin: shimmerMargin,
      shimmerRadius: null,
      baseColor: baseColor,
      gradientColors: gradientColors,
      duration: duration,
      direction: direction,
      radius: radius,
    );
  }

  @override
  State<ShimmerItem> createState() => _ShimmerItemState();
}

class _ShimmerItemState extends State<ShimmerItem>
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
    if (widget.radius != null) {
      return Container(
        height: widget.radius! * 2,
        width: widget.radius! * 2,
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

    return Container(
      height: widget.shimmerSize!.height,
      width: widget.shimmerSize!.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.shimmerRadius!),
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
                borderRadius: BorderRadius.circular(widget.shimmerRadius!),
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
