import 'package:flutter/material.dart';

class TemperatureProgressBar extends StatefulWidget {
  final int minTemp;
  final int maxTemp;

  const TemperatureProgressBar({required this.minTemp, required this.maxTemp, Key? key}) : super(key: key);

  @override
  _TemperatureProgressBarState createState() => _TemperatureProgressBarState();
}

class _TemperatureProgressBarState extends State<TemperatureProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = getProgressValue(widget.minTemp, widget.maxTemp);

    // Set up the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Create a Tween to animate the progress value
    _animation = Tween<double>(begin: 0.0, end: progress).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void didUpdateWidget(TemperatureProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.minTemp != widget.minTemp || oldWidget.maxTemp != widget.maxTemp) {
      // Recalculate progress if temperature changes
      progress = getProgressValue(widget.minTemp, widget.maxTemp);
      _controller.reset();
      _animation = Tween<double>(begin: 0.0, end: progress).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getProgressValue(int minTemp, int maxTemp) {
    int temperatureRange = maxTemp - minTemp;

    if (temperatureRange == 0) {
      return 0.5;
    }

    double averageTemp = (minTemp + maxTemp) / 2;

    // Adjusting range to 0-50 for normalization
    double normalizedProgress = averageTemp / 50.0;

    return normalizedProgress.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20, // Height for progress bar container
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation.value,
                  minHeight: 6.0,
                  backgroundColor: Colors.blueGrey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
