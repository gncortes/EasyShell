import 'package:flutter/material.dart';

import 'presentation/widgets/shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShimmerDemoScreen(),
    );
  }
}

class ShimmerDemoScreen extends StatelessWidget {
  const ShimmerDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerSize = const Size(200, 50);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Animations Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Shimmer.card(
                      radius: BorderRadius.circular(5),
                      size: shimmerSize,
                      shimmerMargin: const EdgeInsets.all(8.0),
                      baseColor: Colors.grey.shade500,
                      gradientColors: [
                        Colors.white,
                        Colors.grey.shade500,
                        Colors.white,
                      ],
                      duration: const Duration(seconds: 3),
                      direction: ShimmerDirection.bottomToTop,
                    ),
                    const Text('Left to Right'),
                    Shimmer.circle(
                      radius: 25,
                      shimmerMargin: const EdgeInsets.all(8.0),
                      baseColor: Colors.grey.shade500,
                      gradientColors: [
                        Colors.white,
                        Colors.grey.shade500,
                        Colors.white,
                      ],
                      duration: const Duration(seconds: 3),
                      direction: ShimmerDirection.bottomToTop,
                    ),
                    const Text('Bottom to Top'),
                    Row(
                      children: [
                        Shimmer.circle(
                          radius: 25,
                          shimmerMargin: const EdgeInsets.only(right: 8.0),
                          baseColor: Colors.grey.shade500,
                          gradientColors: [
                            Colors.white,
                            Colors.grey.shade500,
                            Colors.white,
                          ],
                          duration: const Duration(seconds: 1),
                          direction: ShimmerDirection.leftToRight,
                        ),
                        Shimmer.card(
                          radius: BorderRadius.circular(5),
                          size: shimmerSize,
                          shimmerMargin: const EdgeInsets.all(8.0),
                          baseColor: Colors.grey.shade500,
                          gradientColors: [
                            Colors.white,
                            Colors.grey.shade500,
                            Colors.white,
                          ],
                          duration: const Duration(seconds: 3),
                          direction: ShimmerDirection.bottomToTop,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Shimmer.cardWithChild(
              shimmerMargin: const EdgeInsets.all(16.0),
              baseColor: Colors.grey.shade300,
              gradientColors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300
              ],
              duration: const Duration(seconds: 2),
              direction: ShimmerDirection.leftToRight,
              size: Size(200, 100),
              radius: BorderRadius.circular(10),
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 100,
                width: 200,
                color: Colors.black,
              ),
            ),
            Shimmer.circleWithChild(
              shimmerMargin: const EdgeInsets.all(16.0),
              baseColor: Colors.grey.shade300,
              gradientColors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300
              ],
              duration: const Duration(seconds: 2),
              direction: ShimmerDirection.leftToRight,
              radius: 30,
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 30,
                width: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
