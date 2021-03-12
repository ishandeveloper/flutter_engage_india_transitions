import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_engage_india_transitions/components/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Engage Transitions',
      home: MainWrapper(),
    );
  }
}

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper>
    with TickerProviderStateMixin {
  // Animation
  Animation<double> rippleAnimation;

  // Controller
  AnimationController controller;

  // Text Animation
  Animation<double> textAnimation;

  // Dash Images Tween
  Animation<double> dashAnimation;

  int dashIterationCount = 1;

  @override
  void initState() {
    // initRippleAnimation();
    initDashAnimation();
    super.initState();
  }

  void initDashAnimation() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800 ~/ dashIterationCount));

    dashAnimation = Tween<double>(begin: 1, end: 3).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          dashIterationCount++;
          if (dashIterationCount > 4) {
            initRippleAnimation();
          } else {
            controller.reset();
            controller.forward();
          }
        }
      });

    controller.forward();
  }

  void initRippleAnimation() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    rippleAnimation = Tween<double>(begin: 0, end: 2000).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          initTextFadeAnimation();
        }
      });
    controller.forward();
  }

  void initTextFadeAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    textAnimation = Tween<double>(begin: 0, end: 1000).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        // if (status == AnimationStatus.completed) {}
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        if (dashAnimation?.value != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/dash-${dashAnimation.value.floor()}.png"))),
            ),
          ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('flutterindia.dev',
                  style: TextStyle(color: Color(0xff025095), fontSize: 20)),
            ],
          ),
        ),
        if (rippleAnimation?.value != null)
          RippleAnimationWrapper(
              rippleAnimation: rippleAnimation, textAnimation: textAnimation),
      ],
    ));
  }
}
