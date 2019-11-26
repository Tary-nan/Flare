import 'package:flutter/material.dart';
import 'package:pressence_tary/demo_flare.dart';
import 'tracking_input.dart';
import 'package:flutter/services.dart';
import 'scan.dart';
import 'exampleOne/change_color.dart';

void main() {
  ///enleve les boutons Android.
  //SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Water Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChangeColor(),
      debugShowCheckedModeBanner: false,
      //home: TrackingInput(),
    );
  }
}

