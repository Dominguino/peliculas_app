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

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider incializando');

    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    // lo del int hace que sea opcional pasar ese parametro y si no se pasa le da valor "1"
    var url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    final Map<String, dynamic> decodeData = json.decode(jsonData);

    //
    //para comprobar que la conexión se realiza
    //if (response.statusCode != 200) return print('error');

    //  print(nowPlayingResponse.results[0].title);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    final jsonData = await _getJsonData('3/movie/popular', 1);

    final popularResponse = PopularResponse.fromJson(jsonData);

    final Map<String, dynamic> decodeData = json.decode(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    print(popularMovies[0]);
    notifyListeners();

    _popularPage++;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    print('pidiendo info al servidor - Cast');

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
