import 'package:flutter/material.dart';
import 'fish.dart';

class AquariumScreen extends StatefulWidget {
  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen> {
  List<Fish> fishList = [];
  Color selectedColor = Colors.blue;
  double selectedSpeed = 1.0;

  void _addFish() {
    if (fishList.length < 10) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: selectedSpeed));
      });
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
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
            ),
            child: Stack(
              children: fishList.map((fish) => fish.buildFish()).toList(),
            ),
          ),
          SizedBox(height: 20),
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
                  // Add functionality to save to local storage
                },
                child: Text('Save Settings'),
              ),
            ],
          ),
          SizedBox(height: 20),
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
          DropdownButton<Color>(
            value: selectedColor,
            items: [
              DropdownMenuItem(value: Colors.blue, child: Text("Blue")),
              DropdownMenuItem(value: Colors.red, child: Text("Red")),
              DropdownMenuItem(value: Colors.green, child: Text("Green")),
            ],
            onChanged: (color) {
              setState(() {
                selectedColor = color!;
              });
            },
          ),
        ],
      ),
    );
  }
}
