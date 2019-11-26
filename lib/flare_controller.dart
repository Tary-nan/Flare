import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_controller.dart';

class AnimationControls extends FlareController{


  FlutterActorArtboard _artboard;
  // my board

  ActorAnimation _fillAnimation;
  // behavior

  /// notre cube de glace se déplaçant sur l'axe des
  /// ordonnées en fonction de la consommation d'eau actuelle
  ActorAnimation _iceboyMoveY;

  /// utilisé pour le mélange d'animations
  final List<FlareAnimationLayer> _baseAnimations = [];

  /// notre remplissage global
  double _waterFill = 0.00;
  /// quantité actuelle d'eau consommée
  double _currentWaterFill = 0;

  /// temps utilisé pour lisser le mouvement de la ligne de remplissage
  double _smoothTime = 5;


  ///Nous pouvons initialiser certains de nos vars que nous avons déclarés
  ///précédemment et configurer notre fonction "avance" qui fait avancer
  ///l'animation de la planche graphique en fonction du temps écoulé.


  @override
  void initialize(FlutterActorArtboard artboard) {

    _artboard = artboard;

    _fillAnimation = artboard.getAnimation("water up");
    _iceboyMoveY = artboard.getAnimation("iceboy_move_up");

  }


  void setViewTransform(Mat2D viewTransform){}

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    //we need this separate from our generic mixing animations,
    // b/c the animation duration is needed in this calculation
    if (artboard.name.compareTo("Artboard") == 0) {
      _currentWaterFill +=
          (_waterFill - _currentWaterFill) * min(1, elapsed * _smoothTime);
      _fillAnimation.apply(
          _currentWaterFill * _fillAnimation.duration, artboard, 1);
      _iceboyMoveY.apply(
          _currentWaterFill * _iceboyMoveY.duration, artboard, 1);
    }

    int len = _baseAnimations.length - 1;
    for (int i = len; i >= 0; i--) {
      FlareAnimationLayer layer = _baseAnimations[i];
      layer.time += elapsed;
      layer.mix = min(1.0, layer.time / 0.01);
      layer.apply(_artboard);

      if (layer.isDone) {
        _baseAnimations.removeAt(i);
      }
    }
    return true;
  }

  ///called from the 'tracking_input'
  void playAnimation(String animName) {
    ActorAnimation animation = _artboard.getAnimation(animName);

    if (animation != null) {
      _baseAnimations.add(FlareAnimationLayer()
        ..name = animName
        ..animation = animation);
    }
  }

  ///called from the 'tracking_input'
  ///updates the water fill line
  void updateWaterPercent(double amt) {
    _waterFill = amt;
  }

  ///called from the 'tracking_input'
  ///resets the water fill line
  void resetWater() {
    _waterFill = 0;
  }
}

