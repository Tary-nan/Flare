import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

enum AnimationPlay{
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped,
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {

  // create flare control
  final FlareControls animationControls = FlareControls();

  bool _isOpen = false;

  AnimationPlay _animaionToPlay = AnimationPlay.Deactivate;

  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: AnimationHeight,
      width: AnimationWidth,
        child: GestureDetector(
          onTapUp: (tapInfo){
            setState(() {

            var positionOnTap = (context.findRenderObject() as RenderBox)
            .globalToLocal(tapInfo.globalPosition);

            // l endroit ou vous toucher

            var topHalfTouched = positionOnTap.dy < AnimationHeight / 2;
            var leftSideTouched = positionOnTap.dx < AnimationWidth / 3;
            var rightSideTouched = positionOnTap.dx < (AnimationWidth / 3) * 2;
            var middleTouched = !leftSideTouched && !rightSideTouched ;

            if(leftSideTouched && topHalfTouched ){
              print('top left');
              _setAnimationToPlay(AnimationPlay.CameraTapped);
            }else if( middleTouched && topHalfTouched){
                print('top right');

              _setAnimationToPlay(AnimationPlay.ImageTapped);

            }else if(rightSideTouched && topHalfTouched){
              print('top Middle');
              _setAnimationToPlay(AnimationPlay.PulseTapped);

            }else{
              if(_isOpen){
                print('Bottom  close');
                _setAnimationToPlay(AnimationPlay.Deactivate);
              }else{
                print('Bottom Open');
                _setAnimationToPlay(AnimationPlay.Activate);

              }

            }

              _isOpen = !_isOpen ;
            });


          },
            child: FlareActor(
              'assets/MultiOptionButton.flr',
              controller: animationControls,
              animation: _getAnimationName(_animaionToPlay), ))
            //child: FlareActor('assets/MultiOptionButton.flr', animation: _isOpen ? 'activate' : 'deactivate', ))
    );
  }

  String _getAnimationName(AnimationPlay animationToPlay){
    switch (animationToPlay){
      case AnimationPlay.Activate:
        return 'activate';
      case AnimationPlay.Deactivate:
        return 'deactivate';
      case AnimationPlay.CameraTapped:
        return 'camera_tapped';
      case AnimationPlay.PulseTapped:
        return 'pulse_tapped';
      case AnimationPlay.ImageTapped:
        return 'image_tapped';
      default :
        return 'deactivate';
    }
  }

  void _setAnimationToPlay(AnimationPlay animation){

    // Before
    //setState(() {
      //_animaionToPlay = animation ;
    //});

    animationControls.play(_getAnimationName(animation));
  }
}


