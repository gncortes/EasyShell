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

/// Representa um grupo de cores com suas variações
class ColorGroup {
  final String name;
  final Color baseColor;
  final List<Color> regularGradient;
  final List<Color> strongGradient;
  final List<Color> extraStrongGradient;

  ColorGroup({
    required this.name,
    required this.baseColor,
    required this.regularGradient,
    required this.strongGradient,
    required this.extraStrongGradient,
  });
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
  Color color = Colors.grey;
  List<Color> variants = [
    Colors.grey.shade300,
    Colors.grey.shade400, // baseColor
    Colors.grey.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    final shimmerDuration = Duration(
      milliseconds: (_currentDuration * 1000).round(),
    );
    final selectedColorGroup = _colorGroups[_currentColorSet];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Animations Demo'),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (context) => const ColorPickerScreen(),
                ),
              );
              if (result != null) {
                setState(() {
                  color = result["color"];
                  variants = result["variants"];
                });
              }
            },
            icon: Icon(Icons.color_lens),
          ),
        ],
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
                    min: 0.1,
                    max: 5.0,
                    divisions: 20,
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
                const Text('Colors: '),
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
                    _colorGroups.length,
                    (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: _colorGroups[index].baseColor,
                          ),
                          const SizedBox(width: 8),
                          Text(_colorGroups[index].name),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Column(
                  children: [
                    const Text(
                      'Regular Gradient',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors: selectedColorGroup.regularGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors: selectedColorGroup.regularGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Strong Gradient',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors: selectedColorGroup.strongGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors: selectedColorGroup.strongGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Extra Strong Gradient',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors:
                              selectedColorGroup.extraStrongGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: selectedColorGroup.baseColor,
                          gradientColors:
                              selectedColorGroup.extraStrongGradient,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'My Selection',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Strong Gradient 2',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Extra Strong Gradient 3',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ShimmerWidget.circle(
                          radius: 50,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                        const SizedBox(width: 10),
                        ShimmerWidget.card(
                          radius: BorderRadius.circular(5),
                          size: const Size(350, 100),
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: color,
                          gradientColors: variants,
                          duration: shimmerDuration,
                          direction: _currentDirection,
                        ),
                      ],
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

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  MaterialColor? selectedColor;
  final List<Color> selectedVariants = [];

  final Map<MaterialColor, String> materialColors = {
    Colors.red: "Red",
    Colors.blue: "Blue",
    Colors.green: "Green",
    Colors.yellow: "Yellow",
    Colors.purple: "Purple",
    Colors.orange: "Orange",
    Colors.teal: "Teal",
    Colors.grey: "Grey",
  };

  final Map<int, String> shadeNames = {
    50: "Shade 50",
    100: "Shade 100",
    200: "Shade 200",
    300: "Shade 300",
    400: "Shade 400",
    500: "Shade 500",
    600: "Shade 600",
    700: "Shade 700",
    800: "Shade 800",
    900: "Shade 900",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Color and Shades"),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedColor != null && selectedVariants.isNotEmpty) {
                Navigator.pop(context, {
                  'color': selectedColor,
                  'variants': selectedVariants,
                });
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Material Color Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<MaterialColor>(
              isExpanded: true,
              value: selectedColor,
              hint: const Text("Select a Material Color"),
              items: materialColors.entries.map((entry) {
                final color = entry.key;
                final name = entry.value;
                return DropdownMenuItem(
                  value: color,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: color,
                        radius: 12,
                      ),
                      const SizedBox(width: 10),
                      Text(name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor = value;
                  selectedVariants.clear(); // Clear previous variants
                });
              },
            ),
          ),
          // Shade Selector
          if (selectedColor != null)
            Expanded(
              child: ListView(
                children: shadeNames.entries.map((entry) {
                  final shade = entry.key;
                  final name = entry.value;
                  final color = selectedColor![shade];
                  final isSelected = selectedVariants.contains(color);

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color,
                    ),
                    title: Text(name),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedVariants.remove(color);
                        } else {
                          if (color != null) selectedVariants.add(color);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

// Lista de grupos de cores como objetos
final List<ColorGroup> _colorGroups = [
  ColorGroup(
    name: 'Grey',
    baseColor: Colors.grey.shade400,
    regularGradient: [
      Colors.grey.shade300,
      Colors.grey.shade400, // baseColor
      Colors.grey.shade300,
    ],
    strongGradient: [
      Colors.grey.shade700,
      Colors.grey.shade400, // baseColor
      Colors.grey.shade700,
    ],
    extraStrongGradient: [
      Colors.grey.shade900,
      Colors.grey.shade400, // baseColor
      Colors.grey.shade900,
    ],
  ),
  ColorGroup(
    name: 'White',
    baseColor: Colors.white,
    regularGradient: [
      Colors.white,
      Colors.white, // baseColor
      Colors.white,
    ],
    strongGradient: [
      Colors.grey.shade300,
      Colors.white, // baseColor
      Colors.grey.shade300,
    ],
    extraStrongGradient: [
      Colors.grey.shade500,
      Colors.white, // baseColor
      Colors.grey.shade500,
    ],
  ),
  ColorGroup(
    name: 'Black',
    baseColor: Colors.black,
    regularGradient: [
      Colors.grey.shade800,
      Colors.grey.shade100, // Added shade100
      Colors.black, // baseColor
      Colors.grey.shade800,
    ],
    strongGradient: [
      Colors.grey.shade900,
      Colors.grey.shade100, // Added shade100
      Colors.black, // baseColor
      Colors.grey.shade900,
    ],
    extraStrongGradient: [
      Colors.black,
      Colors.grey.shade100, // Added shade100
      Colors.black, // baseColor
      Colors.black,
    ],
  ),
  ColorGroup(
    name: 'Red',
    baseColor: Colors.red.shade400,
    regularGradient: [
      Colors.red.shade300,
      Colors.red.shade400, // baseColor
      Colors.red.shade300,
    ],
    strongGradient: [
      Colors.red.shade700,
      Colors.red.shade400, // baseColor
      Colors.red.shade700,
    ],
    extraStrongGradient: [
      Colors.red.shade900,
      Colors.red.shade400, // baseColor
      Colors.red.shade900,
    ],
  ),
  ColorGroup(
    name: 'Yellow',
    baseColor: Colors.yellow.shade400,
    regularGradient: [
      Colors.yellow.shade300,
      Colors.yellow.shade400, // baseColor
      Colors.yellow.shade300,
    ],
    strongGradient: [
      Colors.yellow.shade700,
      Colors.yellow.shade400, // baseColor
      Colors.yellow.shade700,
    ],
    extraStrongGradient: [
      Colors.yellow.shade900,
      Colors.yellow.shade400, // baseColor
      Colors.yellow.shade900,
    ],
  ),
  ColorGroup(
    name: 'Purple',
    baseColor: Colors.purple.shade400,
    regularGradient: [
      Colors.purple.shade300,
      Colors.purple.shade400, // baseColor
      Colors.purple.shade300,
    ],
    strongGradient: [
      Colors.purple.shade700,
      Colors.purple.shade400, // baseColor
      Colors.purple.shade700,
    ],
    extraStrongGradient: [
      Colors.purple.shade900,
      Colors.purple.shade400, // baseColor
      Colors.purple.shade900,
    ],
  ),
];
