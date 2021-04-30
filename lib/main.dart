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
  bool showRow = true;

  onTap() {
    _animationController.forward().whenComplete(() {
      refreshContainer();
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  refreshContainer() {
    print("Animation Completed");
    setState(() {
      showRow = !showRow;
    });
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
                      _animationController.forward().whenComplete(() {
                        refreshContainer();
                      });
                    } else {
                      _animationController.reverse().whenComplete(() {
                        refreshContainer();
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: (500 - 80) * value + 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF4C0BFE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: showRow
                        ? RowWidgetMenu(
                            onTap: onTap,
                          )
                        : ColumnWidgetMenu(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RowWidgetMenu extends StatelessWidget {
  const RowWidgetMenu({Key key, this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Icon(
              Icons.copy,
              color: Colors.white,
            ),
          ),
        ),
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
        Expanded(
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/avatar.png"),
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class ColumnWidgetMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: size.height * .01),
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Color(0xFF6D40FE),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 14,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFF1A00A9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF0A0431),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        Text(
          "Last Century",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        Text(
          "Bloody Tear",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * .01),
        Container(
          width: 5,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: size.height * .01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.loop_rounded,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.pause,
              color: Colors.white,
              size: 30,
            ),
            Icon(
              Icons.model_training,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
        SizedBox(height: size.height * .03),
      ],
    );
  }
}
