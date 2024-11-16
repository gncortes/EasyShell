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
    return _ShimmerCicle(
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

class _ShimmerCardWithChild extends ShimmerWidget {
  final Size size;
  final BorderRadiusGeometry radius;
  final Widget child;
  const _ShimmerCardWithChild({
    super.key,
    required this.size,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
    required this.child,
  });

  @override
  State<_ShimmerCardWithChild> createState() => _ShimmerCardWithChildState();
}

class _ShimmerCardWithChildState extends State<_ShimmerCardWithChild>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget).size.height,
      width: (widget).size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: (widget).radius,
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
                    borderRadius: (widget).radius,
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

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
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
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget).size.height,
      width: (widget).size.width,
      margin: widget.shimmerMargin,
      decoration: BoxDecoration(
        borderRadius: (widget).radius,
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
                borderRadius: (widget).radius,
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

class _ShimmerCicle extends ShimmerWidget {
  final double radius;
  const _ShimmerCicle({
    super.key,
    required this.radius,
    required super.shimmerMargin,
    required super.baseColor,
    required super.gradientColors,
    required super.duration,
    required super.direction,
  });

  @override
  State<_ShimmerCicle> createState() => _ShimmerCicleState();
}

class _ShimmerCicleState extends State<_ShimmerCicle>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget).radius * 2,
      width: (widget).radius * 2,
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

class _ShimmerCircleWithChild extends _ShimmerCicle {
  final Widget child;
  const _ShimmerCircleWithChild({
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
  State<_ShimmerCircleWithChild> createState() =>
      __ShimmerCircleWithChildState();
}

class __ShimmerCircleWithChildState extends State<_ShimmerCircleWithChild>
    with _AnimationControllerMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget).radius * 2,
      width: (widget).radius * 2,
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
          widget.child,
        ],
      ),
    );
  }

  @override
  Duration get animationDuration => widget.duration;

  @override
  TickerProvider get ticker => this;
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

mixin _AnimationControllerMixin on State<StatefulWidget> {
  late AnimationController _controller;

  /// Retorna o `AnimationController` que pode ser usado para animações.
  AnimationController get animationController => _controller;

  /// A duração da animação. Subclasses devem sobrescrever este método.
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
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Verifica se a duração mudou e recria o controlador, se necessário.
    if (_controller.duration != animationDuration) {
      _controller.dispose();
      _controller = AnimationController(
        vsync: this,
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
