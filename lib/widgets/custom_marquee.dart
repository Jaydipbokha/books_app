import 'package:flutter/material.dart';

class CustomMarquee extends StatefulWidget {
  final String text;
  final double velocity; // pixels per second
  final TextStyle? style;

  const CustomMarquee({
    Key? key,
    required this.text,
    this.velocity = 50.0,
    this.style,
  }) : super(key: key);

  @override
  _CustomMarqueeState createState() => _CustomMarqueeState();
}

class _CustomMarqueeState extends State<CustomMarquee> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _textWidth = 0.0; // Initialize with 0.0
  double _screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 365),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _screenWidth = constraints.maxWidth;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_textWidth == 0.0) {
              // Don't animate yet until we know text size
              return child!;
            }

            double elapsedSeconds = _controller.lastElapsedDuration?.inMilliseconds.toDouble() ?? 0;
            double dx = (_screenWidth - (elapsedSeconds / 1000 * widget.velocity) % (_textWidth + _screenWidth));

            return Transform.translate(
              offset: Offset(dx, 0),
              child: child,
            );
          },
          child: MeasureSize(
  onChange: (size) {
    if (size.width != _textWidth) {
      setState(() {
        _textWidth = size.width;
      });
    }
  },
  child: SizedBox(
    height: widget.style?.fontSize != null ? widget.style!.fontSize! * 1.5 : 30,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.text,
        overflow: TextOverflow.visible,
        style: widget.style ?? const TextStyle(fontSize: 20),
      ),
    ),
  ),
),

        );
      },
    );
  }
}

/// Helper widget to measure size
class MeasureSize extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onChange;

  const MeasureSize({Key? key, required this.child, required this.onChange}) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _key.currentContext;
      if (context == null) return;
      final newSize = context.size;
      if (newSize != null) {
        widget.onChange(newSize);
      }
    });

    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
