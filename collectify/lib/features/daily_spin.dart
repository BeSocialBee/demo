import 'package:flutter/material.dart';
import 'dart:math';


class SpinWheelPage extends StatefulWidget {
  @override
  _SpinWheelPageState createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  final List<String> rewards = [
    "Ödül 1",
    "Ödül 2",
    "Ödül 3",
    "Ödül 4",
    "Ödül 5",
    "Ödül 6",
    "Ödül 7",
    "Ödül 8",
  ];

  int selectedIndex = -1;
  bool canSpin = true;

  void spinWheel() {
    if (canSpin) {
      final random = Random();
      final selected = random.nextInt(rewards.length);
      setState(() {
        selectedIndex = selected;
        canSpin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Günlük Çark"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IndexedStack(
              index: selectedIndex,
              children: rewards
                  .map((reward) => RewardCard(reward: reward))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: canSpin ? spinWheel : null,
              child: Text("Çevir"),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String reward;

  RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          reward,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
