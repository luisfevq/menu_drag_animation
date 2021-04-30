import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

const double sizeLeft = 80;
const double sizeRight = 80;
const double sizeBottom = 20;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  onTap() {
    _animationController.forward();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 800),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                double value = _animationController.value;
                return Positioned(
                  bottom: (0 - sizeBottom) * value + sizeBottom,
                  left: (0 - sizeLeft) * value + sizeLeft,
                  right: (0 - sizeRight) * value + sizeRight,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.primaryDelta.isNegative) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: (500 - 80) * value + 80,
                      decoration: BoxDecoration(
                        color: Color(0xFF4C0BFE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: onTap,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF0A0431),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
