import 'package:flutter/material.dart';
import 'package:otaku_life/aboutUs_page.dart';
import 'package:otaku_life/animeList_page_all_users.dart';
import 'package:otaku_life/settings_page.dart';

import 'searchScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

        theme: ThemeData(

        appBarTheme: const AppBarTheme(
        color: Colors.black,
      ),
        ),
      initialRoute: '/anime list',
      routes: {

        '/anime list': (context) => const AnimeList(),
        '/settings': (context) => const Settings(),
        '/about us': (context) => const AboutUs(),
        '/search screen': (context) => const SearchScreen(),

      },
    );
  }
}
