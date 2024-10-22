import 'package:flutter/material.dart';
import 'dart:math';
import 'fish.dart';

class AquariumScreen extends StatefulWidget {
  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen>
    with SingleTickerProviderStateMixin {
  List<Fish> fishList = [];
  Color selectedColor = Colors.red; // Default fish color (red)
  double selectedSpeed = 1.0;
  bool collisionEffectEnabled = true;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _controller.addListener(_updateFishPositions);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Add fish to the aquarium
  void _addFish() {
    if (fishList.length < 10) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: selectedSpeed));
      });
    }
  }

  // Update the positions of fish and check for collisions
  void _updateFishPositions() {
    setState(() {
      for (var fish in fishList) {
        fish.moveFish(); // Move fish
      }
      if (collisionEffectEnabled) {
        _checkAllCollisions(); // Check for collisions if enabled
      }
    });
  }

  // Check if two fish collide and apply behavior
  void _checkForCollision(Fish fish1, Fish fish2) {
    if ((fish1.position.dx - fish2.position.dx).abs() < 20 &&
        (fish1.position.dy - fish2.position.dy).abs() < 20) {
      fish1.changeDirection();
      fish2.changeDirection();
      setState(() {
        fish1.color = Random().nextBool()
            ? Colors.red
            : Colors.green; // Random color change
      });
    }
  }

  // Check all fish for potential collisions
  void _checkAllCollisions() {
    for (int i = 0; i < fishList.length; i++) {
      for (int j = i + 1; j < fishList.length; j++) {
        _checkForCollision(fishList[i], fishList[j]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtual Aquarium'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Container that represents the aquarium
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue, // Set the aquarium background to blue
              border: Border.all(color: Colors.white),
            ),
            child: Stack(
              children: fishList.map((fish) => fish.buildFish()).toList(),
            ),
          ),
          SizedBox(height: 20),
          // Buttons to add fish and save settings
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _addFish,
                child: Text('Add Fish'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Save settings to local storage (to be implemented)
                },
                child: Text('Save Settings'),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Slider to control fish speed
          Slider(
            value: selectedSpeed,
            onChanged: (newSpeed) {
              setState(() {
                selectedSpeed = newSpeed;
              });
            },
            min: 0.5,
            max: 3.0,
            divisions: 5,
            label: '$selectedSpeed',
          ),
          // Dropdown to select fish color excluding blue (to avoid blending with the background)
          DropdownButton<Color>(
            value: selectedColor,
            items: [
              DropdownMenuItem(value: Colors.red, child: Text("Red")),
              DropdownMenuItem(value: Colors.green, child: Text("Green")),
              DropdownMenuItem(value: Colors.yellow, child: Text("Yellow")),
              DropdownMenuItem(value: Colors.orange, child: Text("Orange")),
              DropdownMenuItem(value: Colors.purple, child: Text("Purple")),
            ],
            onChanged: (color) {
              setState(() {
                selectedColor = color!;
              });
            },
          ),
          // Toggle switch for enabling/disabling collision effect
          SwitchListTile(
            title: Text('Enable Collision Effect'),
            value: collisionEffectEnabled,
            onChanged: (bool value) {
              setState(() {
                collisionEffectEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
