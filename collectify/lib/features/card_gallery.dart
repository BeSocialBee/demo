import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CardGallery extends StatelessWidget {
  final List<Image> images = [
    Image.asset('images/seb.jpeg'),
    Image.asset('images/seb-alonso.jpeg'),
    Image.asset('images/seb1.jpeg'),
    Image.asset('images/seb2.jpeg'),
    Image.asset('images/seb3.jpeg'),
    Image.asset('images/seb4.jpeg'),
    Image.asset('images/seb5.jpeg'),
    Image.asset('images/seb6.jpeg'),
    Image.asset('images/seb7.jpeg'),
    Image.asset('images/seb8.jpeg')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resim Gösterisi'),
        ),
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              scrollDirection: Axis.vertical,
              height: 400.0, // Gösterici yüksekliği
              enlargeCenterPage: true,
              autoPlay: true, // Otomatik oynatma
              aspectRatio: 16 / 9, // En boy oranı
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8, // Görünen öğelerin genişliği
            ),
            items: images.map((Image imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: images[1]
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
