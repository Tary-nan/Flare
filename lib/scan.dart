import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class BarCodeScan extends StatefulWidget {
  @override
  _BarCodeScanState createState() => _BarCodeScanState();
}

class _BarCodeScanState extends State<BarCodeScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        child: FlareActor('assets/Barcode.flr', alignment:Alignment.center, fit:BoxFit.contain, animation:"barcode"),
      ),
    );
  }
}
