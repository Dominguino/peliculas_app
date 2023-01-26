import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_providers.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 300),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          //color: Colors.red,
          child: ListView.builder(
              itemBuilder: (_, int index) => _CastCard(),
              scrollDirection: Axis.horizontal,
              itemCount: 10),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        //color: Colors.green,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const FadeInImage(
                  image: NetworkImage('https://via.placeholder.com/150x300'),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            const Text(
              'actor.name aslejkfl ñasjdfasdfjkl',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ));
  }
}
