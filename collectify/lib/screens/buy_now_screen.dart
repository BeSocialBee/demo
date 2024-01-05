import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  static String id = 'market_screen';
  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Collectify'),
      ),
      backgroundColor: Colors.red,
      bottomNavigationBar: myBottomNavigationBar(),
    );
  }
}
