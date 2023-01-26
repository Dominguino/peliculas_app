import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
// aqui hay que recibir peliculas y titulos

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {super.key, required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
      print(scrollController.position.pixels);
      print(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        //color: Colors.red,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // si no hay titulo el widget padding que no se muestre
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies
                    .length, //cambiar el itemcount por el numero de pelis que recibamos
                itemBuilder: (_, int index) =>
                    _MoviePoster(widget.movies[index])),
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
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
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
