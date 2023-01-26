import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_app/providers/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    print(moviesProvider.onDisplayMovies);

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
        CardSwiper(movies: moviesProvider.onDisplayMovies),

        //Slider de peliculas
        MovieSlider(
//TODO :
          movies: moviesProvider.popularMovies, //populares
          title: 'Populares', // opcional
          onNextPage: () => moviesProvider.getPopularMovies(),
        ),
      ])),
    );
  }
}
