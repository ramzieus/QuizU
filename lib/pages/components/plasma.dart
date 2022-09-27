import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Plasma extends StatelessWidget {
  const Plasma({super.key});

  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.bubbles,
      particles: 100,
      color: Theme.of(context).secondaryHeaderColor,
      blur: 0.40,
      size: 0.50,
      speed: 2,
      offset: 0,
      blendMode: BlendMode.lighten,
      particleType: ParticleType.circle,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 0,
    );
  }
}
