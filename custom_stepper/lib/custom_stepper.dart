library custom_stepper;

import 'package:flutter/material.dart';

enum CustomStepperType { circle, arrow, bar }

class CustomStepper extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  final List<String> labels;
  final Color activeColor;
  final Color inactiveColor;
  final CustomStepperType type;
  final Duration duration;

  const CustomStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.labels,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.type = CustomStepperType.circle,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case CustomStepperType.circle:
        return _buildCircleStepper();
      case CustomStepperType.arrow:
        return _buildArrowStepper();
      case CustomStepperType.bar:
        return _buildProgressBar();
    }
  }

  /// 🔹 Circle Step (1 → 2 → 3)
  Widget _buildCircleStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.totalSteps, (index) {
        bool isActive = index < widget.currentStep;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (index > 0)
                    Expanded(
                      child: AnimatedContainer(
                        duration: widget.duration,
                        height: 4,
                        color: index < widget.currentStep
                            ? widget.activeColor
                            : widget.inactiveColor,
                      ),
                    ),
                  AnimatedContainer(
                    duration: widget.duration,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive
                          ? widget.activeColor
                          : widget.inactiveColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: widget.duration,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        child: Text("${index + 1}"),
                      ),
                    ),
                  ),
                  if (index < widget.totalSteps - 1)
                    Expanded(
                      child: AnimatedContainer(
                        duration: widget.duration,
                        height: 4,
                        color: (index < widget.currentStep - 1)
                            ? widget.activeColor
                            : widget.inactiveColor,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              AnimatedDefaultTextStyle(
                duration: widget.duration,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? widget.activeColor : Colors.black54,
                ),
                child: Text(widget.labels[index]),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// 🔹 Arrow Step
  Widget _buildArrowStepper() {
    return Row(
      children: List.generate(widget.totalSteps, (index) {
        bool isActive = index < widget.currentStep;

        return Expanded(
          child: AnimatedContainer(
            duration: widget.duration,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive ? widget.activeColor : widget.inactiveColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(index == 0 ? 8 : 0),
                right: Radius.circular(index == widget.totalSteps - 1 ? 8 : 0),
              ),
            ),
            child: Center(
              child: Text(
                widget.labels[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 🔹 Progress Bar Step
  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.labels
              .map((label) => Text(label, style: const TextStyle(fontSize: 12)))
              .toList(),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: widget.currentStep / widget.totalSteps,
            ),
            duration: widget.duration,
            builder: (context, value, child) => LinearProgressIndicator(
              value: value,
              backgroundColor: widget.inactiveColor,
              color: widget.activeColor,
              minHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}
