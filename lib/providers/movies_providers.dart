import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '1fa663d827245be4716dc11352af66ea';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('MoviesProvider incializando');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    //
    //para comprobar que la conexión se realiza
    //if (response.statusCode != 200) return print('error');

    print(nowPlayingResponse.results[0].title);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    popularMovies = [...popularMovies, ...popularResponse.results];

    print(popularMovies[0]);
    notifyListeners();
  }
}
