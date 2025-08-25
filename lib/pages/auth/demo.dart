import 'package:flutter/material.dart';

class StepProgressIndicator extends StatefulWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  State<StepProgressIndicator> createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(StepProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StepPainter(
        currentStep: widget.currentStep,
        totalSteps: widget.totalSteps,
        progress: _animation.value,
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
      ),
    );
  }
}

class _StepPainter extends CustomPainter {
  final int currentStep;
  final int totalSteps;
  final double progress;

  _StepPainter({
    required this.currentStep,
    required this.totalSteps,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final double stepWidth = size.width / (totalSteps - 1);
    final double centerY = size.height / 2;

    // Gambar garis background
    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      linePaint,
    );

    // Gambar progress garis dengan animasi grow
    final double progressX = (currentStep - 1 + progress) * stepWidth;
    canvas.drawLine(
      Offset(0, centerY),
      Offset(progressX, centerY),
      progressPaint,
    );

    // Gambar lingkaran untuk tiap step
    for (int i = 0; i < totalSteps; i++) {
      final double x = i * stepWidth;
      final bool isActive = i < currentStep ||
          (i == currentStep - 1 && progress > 0.9); // step aktif

      final Paint circlePaint = Paint()
        ..color = isActive ? Colors.green : Colors.grey.shade300;

      canvas.drawCircle(Offset(x, centerY), 14, circlePaint);

      // Inner circle (putih biar ada efek border)
      canvas.drawCircle(Offset(x, centerY), 12, Paint()..color = Colors.white);

      // Angka step
      final textPainter = TextPainter(
        text: TextSpan(
          text: "${i + 1}",
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, centerY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _StepPainter oldDelegate) {
    return oldDelegate.currentStep != currentStep ||
        oldDelegate.progress != progress;
  }
}
