import 'package:flutter/material.dart';

class RippleAnimationWrapper extends StatelessWidget {
  const RippleAnimationWrapper({
    Key key,
    @required this.rippleAnimation,
    @required this.textAnimation,
  }) : super(key: key);

  final Animation<double> rippleAnimation;
  final Animation<double> textAnimation;

  @override
  Widget build(BuildContext context) {
    double rippleWidth = (MediaQuery.of(context).size.width + 100) /
        1000 *
        rippleAnimation?.value;
    double rippleHeight = (MediaQuery.of(context).size.height + 100) /
        1000 *
        rippleAnimation?.value;

    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff73cfeb),
                  borderRadius:
                      BorderRadius.circular(1000 - rippleAnimation.value)),
              width: rippleWidth > rippleHeight ? rippleHeight : rippleWidth,
              height: rippleHeight,
            ),
          ),
          if (textAnimation?.value != null)
            Positioned(
              child: Opacity(
                opacity: textAnimation.value / 1000,
                child: Container(
                  child: Center(
                    child: Text(
                      'Welcome Keynote',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 64, color: Colors.white),
                    ),
                  ),
                ),
              ),
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
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
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
