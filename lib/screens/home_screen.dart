import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {},
            )
          ]),
      body: SingleChildScrollView(
          child: Column(children: [
        //TODO: Card Swiper

        //Tarjetas principales
        CardSwiper(),

        //Slider de peliculas
        MovieSlider(),
      ])),
    );
  }
}
