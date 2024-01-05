import 'package:collectify/components/rounded_button.dart';
import 'package:flutter/material.dart';

class CardData {
  final int index;

  CardData(this.index);
}

class CardWidget extends StatelessWidget {
  final CardData card;
  final String name;

  CardWidget(this.card, this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset(
                'images/$name', // Örnek bir görsel URL
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.purple[100]),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Card ${card.index}'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sell',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        );
  }
}

class CardWidget2 extends StatelessWidget {
  final String name;

  CardWidget2(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Image.asset(
                'images/$name', // Örnek bir görsel URL
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.purple[100]),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Card $name'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sell',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        );
  }
}
