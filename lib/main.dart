import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_providers.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

//widget para el estado del provider
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

// widget de l APLICACIÓN
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Colors.indigo,
      )),
    );
  }
}
