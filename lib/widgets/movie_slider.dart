import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatelessWidget {
// aqui hay que recibir peliculas y titulos

  final List<Movie> movies;
  final String? title;

  const MovieSlider({super.key, required this.movies, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        //color: Colors.red,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // si no hay titulo el widget padding que no se muestre
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies
                    .length, //cambiar el itemcount por el numero de pelis que recibamos
                itemBuilder: (_, int index) => _MoviePoster(movies[index])),
          )
        ]));
  }
}

class _MoviePoster extends StatelessWidget {
  // el "_" al inicio del nombre, para marcar que es privado, solo se usa en esta clase

  //TODO
  final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 190,
        //color: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ]));
  }
}
