import 'package:flutter/material.dart';
import 'dart:math';

class Fish {
  final Color color;
  final double speed;
  Offset position;
  Random random = Random();

  Fish({required this.color, required this.speed})
      : position = Offset(150, 150); // Initial position

  Widget buildFish() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: (1000 / speed).toInt()),
      left: position.dx,
      top: position.dy,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void moveFish() {
    // Add logic to move the fish randomly and bounce off the edges
  }

  void changeDirection() {
    // Change direction of the fish
  }
}
