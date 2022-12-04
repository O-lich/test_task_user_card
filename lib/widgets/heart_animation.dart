import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimated;
  final Duration duration;
  final VoidCallback? onEnd;

  HeartAnimation(
      {Key? key,
      required this.child,
      required this.isAnimated,
      this.duration = const Duration(milliseconds: 150),
      this.onEnd})
      : super(key: key);

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(HeartAnimation oldWidget) {
    if (widget.isAnimated != oldWidget.isAnimated) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future startAnimation() async {
    if (widget.isAnimated) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 400),
      );
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
