import 'package:flutter/material.dart';
import 'package:pressence_tary/smart_flare_animation.dart';
import 'package:smart_flare/smart_flare.dart';

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {

  bool _isOpen = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8485f0),
      body: Container(
        alignment: Alignment.centerRight,
        child: PanFlareActor(
          width: 159.0,
          height: MediaQuery.of(context).size.height,
          filename: "assets/slideout-menu.flr",
          openAnimation: 'open',
          closeAnimation: 'close',
          direction: ActorAdvancingDirection.RightToLeft,
          threshold: 20.0,
          reverseOnRelease: true,
          activeAreas: [
            RelativePanArea(
                area: Rect.fromLTWH(0, 0.7, 1.0, 0.3),
                debugArea: false
            )
          ],
        ),
      )
    );
  }
}


/*
 Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareAnimation()),
 */


