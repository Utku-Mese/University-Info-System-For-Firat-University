import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final num digit;
  final Duration duration;
  final TextStyle textStyle;

  const AnimatedCounter({
    required Key key,
    required this.digit,
    this.duration = const Duration(milliseconds: 1000),
    required this.textStyle,
  }) : super(key: key);

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double displayDigit;

  @override
  void initState() {
    super.initState();

    displayDigit = widget.digit.toDouble();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.digit != widget.digit) {
      _animationController.reset();
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.addListener(() {
      setState(() {
        displayDigit = double.parse(widget.digit.toStringAsFixed(2));
      });
    });

    final animatedValue = displayDigit * _animation.value;

    return Text(
      // to double counter
      // animatedValue.toStringAsFixed(2),
      animatedValue.toInt().toString(),
      style: widget.textStyle,
    );
  }
}
