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
    _animationController.forward();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _animationController.addListener(() {
      listenAnimation(_animationController.value);
    });
    super.initState();
  }

  void listenAnimation(double value) {
    if (value > .5) {
      setState(() {
        showRow = false;
      });
    } else {
      setState(() {
        showRow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height,
            color: Colors.white,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: ListView(
              children: [
                Container(
                  width: size.width,
                  height: size.height * .2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCardAlbum(
                        size: size,
                        title: "Asap Rocky",
                        imageName: "assets/1827681.png",
                      ),
                      _buildCardAlbum(
                        size: size,
                        title: "EDX",
                        imageName: "assets/person1.png",
                      ),
                      _buildCardAlbum(
                        size: size,
                        title: "Tchc",
                        imageName: "assets/person3.png",
                      ),
                      _buildCardAlbum(
                        size: size,
                        title: "Avicii",
                        imageName: "assets/person4.png",
                      ),
                      _buildCardAlbum(
                        size: size,
                        title: "Maroon 5",
                        imageName: "assets/1827681.png",
                      ),
                    ],
                  ),
                ),
                Text(
                  "Recently played",
                  style: TextStyle(
                    color: Color(0xFF1A00A9),
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildCardRecentlyPlayed(
                  size: size,
                  title: "Lxst Cxntury",
                  subTitle: "Bloody Tear",
                  imageName: "assets/img1.png",
                  artistImage: "assets/avatar.png",
                ),
                _buildCardRecentlyPlayed(
                  size: size,
                  title: "SuicideBoyS",
                  subTitle: "Leave Me Alone",
                  imageName: "assets/img2.png",
                  artistImage: "assets/avatar.png",
                ),
                _buildCardRecentlyPlayed(
                  size: size,
                  title: "SuicideBoyS",
                  subTitle: "Leave Me Alone",
                  imageName: "assets/img3.png",
                  artistImage: "assets/avatar.png",
                ),
                _buildCardRecentlyPlayed(
                  size: size,
                  title: "SuicideBoyS",
                  subTitle: "Leave Me Alone",
                  imageName: "assets/img4.png",
                  artistImage: "assets/avatar.png",
                ),
              ],
            ),
          ),
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
                    child: showRow
                        ? RowWidgetMenu(
                            onTap: onTap,
                            animation: _animationController,
                          )
                        : ColumnWidgetMenu(
                            animation: _animationController,
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardAlbum({Size size, String title, String imageName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: size.height * .14,
          margin: EdgeInsets.only(
            right: 15.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imageName),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6D40FE),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCardRecentlyPlayed({
    Size size,
    String title,
    String subTitle,
    String imageName,
    String artistImage,
  }) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(30.0),
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF0A0431),
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: AssetImage(imageName),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(artistImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class RowWidgetMenu extends AnimatedWidget {
  RowWidgetMenu({this.onTap, Animation<double> animation})
      : super(listenable: animation);
  final VoidCallback onTap;
  Animation<double> get animation => listenable;

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
              image: DecorationImage(
                image: AssetImage("assets/img2.png"),
                fit: BoxFit.cover,
              ),
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

class ColumnWidgetMenu extends AnimatedWidget {
  ColumnWidgetMenu({Animation<double> animation})
      : super(listenable: animation);
  Animation<double> get animation => listenable;
  @override
  Widget build(BuildContext context) {
    return animation.value > 0.75
        ? LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints;
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: size.maxHeight * .01,
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0xFF6D40FE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.maxHeight * .01,
                    child: Container(
                      width: size.maxWidth,
                      height: size.maxHeight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: const Duration(milliseconds: 300),
                            builder: (context, value, _) {
                              final sizePosition = size.maxHeight * .58;
                              return Positioned(
                                bottom: (size.maxHeight * .5 - sizePosition) *
                                        value +
                                    sizePosition,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1A00A9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              );
                            },
                          ),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: const Duration(milliseconds: 250),
                            builder: (context, value, _) {
                              final sizePosition = size.maxHeight * .6;
                              return Positioned(
                                bottom: (size.maxHeight * .5 - sizePosition) *
                                        value +
                                    sizePosition,
                                child: Transform.scale(
                                  alignment: Alignment.bottomCenter,
                                  scale: -value + 1,
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0A0431),
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage("assets/img2.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) {
                      final sizePosition = size.maxHeight * .45;
                      return Positioned(
                        bottom: (size.maxHeight * .25 - sizePosition) * value +
                            sizePosition,
                        child: Column(
                          children: [
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
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: size.maxHeight * .25,
                    child: Container(
                      width: 5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: size.maxHeight * .08,
                    left: 20.0,
                    right: 20.0,
                    child: Row(
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
                  ),
                ],
              );
            },
          )
        : const SizedBox.shrink();
  }
}
