import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

List<Color> exampleColors = <Color>[Colors.red, Colors.green, Colors.blue];

class ChangeColor extends StatefulWidget {
  @override
  _ChangeColorState createState() => _ChangeColorState();
}

class _ChangeColorState extends State<ChangeColor> with FlareController {
  FlutterColorFill _fill;
  void initialize(FlutterActorArtboard artboard) {
    // Find our "Num 2" shape and get its fill so we can change it programmatically.
    FlutterActorShape shape = artboard.getNode("Num 2");
    _fill = shape?.fill as FlutterColorFill;
  }

  void setViewTransform(Mat2D viewTransform) {}

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // advance is called whenever the flare artboard is about to update (before it draws).
    Color nextColor = exampleColors[_counter % exampleColors.length];
    if (_fill != null) {
      _fill.uiColor = nextColor;
    }
    // Return false as we don't need to be called again. You'd return true if you wanted to manually animate some property.
    return false;
  }

  // We're going to use the counter to iterate the color.
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
      // advance the controller
      isActive.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("change_color"),
      ),
      body: FlareActor("assets/Change Color Example.flr",
          fit: BoxFit.contain, alignment: Alignment.center, controller: this),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
