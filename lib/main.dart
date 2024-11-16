import 'package:flutter/material.dart';

import 'presentation/widgets/shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shimmer Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ShimmerDemoScreen(),
    );
  }
}

class ShimmerDemoScreen extends StatefulWidget {
  const ShimmerDemoScreen({super.key});

  @override
  State<ShimmerDemoScreen> createState() => _ShimmerDemoScreenState();
}

class _ShimmerDemoScreenState extends State<ShimmerDemoScreen> {
  ShimmerDirection _currentDirection = ShimmerDirection.leftToRight;
  double _currentDuration = 2.0; // in seconds
  int _currentColorSet = 0;
  Color _currentBaseColor = Colors.grey.shade400;

  // List of predefined shimmer gradients
  final List<List<Color>> _colorOptions = [
    [Colors.grey.shade300, Colors.grey.shade100, Colors.grey.shade300],
    [Colors.blue.shade300, Colors.blue.shade100, Colors.blue.shade300],
    [Colors.pink.shade300, Colors.pink.shade100, Colors.pink.shade300],
    [Colors.green.shade300, Colors.green.shade100, Colors.green.shade300],
  ];

  // List of predefined base colors
  final List<Color> _baseColorOptions = [
    Colors.grey.shade400,
    Colors.blue.shade400,
    Colors.pink.shade400,
    Colors.green.shade400,
    Colors.orange.shade400,
  ];

  @override
  Widget build(BuildContext context) {
    final shimmerDuration = Duration(
      milliseconds: (_currentDuration * 10).round(),
    );
    final gradientColors = _colorOptions[_currentColorSet];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Animations Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Direction: '),
                DropdownButton<ShimmerDirection>(
                  value: _currentDirection,
                  onChanged: (ShimmerDirection? newDirection) {
                    if (newDirection != null) {
                      setState(() {
                        _currentDirection = newDirection;
                      });
                    }
                  },
                  items:
                      ShimmerDirection.values.map((ShimmerDirection direction) {
                    return DropdownMenuItem<ShimmerDirection>(
                      value: direction,
                      child: Text(direction.name),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Duration: '),
                Expanded(
                  child: Slider(
                    value: _currentDuration,
                    min: 0.5,
                    max: 5.0,
                    divisions: 9,
                    label: "${_currentDuration.toStringAsFixed(1)}s",
                    onChanged: (value) {
                      setState(() {
                        _currentDuration = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Gradient Colors: '),
                DropdownButton<int>(
                  value: _currentColorSet,
                  onChanged: (int? newColorSet) {
                    if (newColorSet != null) {
                      setState(() {
                        _currentColorSet = newColorSet;
                      });
                    }
                  },
                  items: List.generate(
                    _colorOptions.length,
                    (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Text('Set ${index + 1}'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Base Color: '),
                DropdownButton<Color>(
                  value: _currentBaseColor,
                  onChanged: (Color? newBaseColor) {
                    if (newBaseColor != null) {
                      setState(() {
                        _currentBaseColor = newBaseColor;
                      });
                    }
                  },
                  items: _baseColorOptions.map((Color baseColor) {
                    return DropdownMenuItem<Color>(
                      value: baseColor,
                      child: Container(
                        height: 20,
                        width: 20,
                        color: baseColor,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 25,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: _currentBaseColor,
                          gradientColors: gradientColors,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(300, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: _currentBaseColor,
                          gradientColors: gradientColors,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                    ShimmerWidget.circleWithChild(
                      shimmerMargin: const EdgeInsets.all(16.0),
                      baseColor: _currentBaseColor,
                      gradientColors: gradientColors,
                      duration: shimmerDuration,
                      direction: _currentDirection,
                      radius: 40,
                      child: Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.yellow.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
