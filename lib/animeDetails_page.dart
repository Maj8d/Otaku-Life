import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otaku_life/Models/AnimeModel.dart';
import 'package:otaku_life/Repository/anime_repository.dart';


class AnimeDetails extends StatefulWidget {
  const AnimeDetails({Key? key,  this.animeId}) : super(key: key);
  final int? animeId;
  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  bool isPressed = false;
  bool isPressed2 = false;


  void toggleButton() {
    setState(() {
      isPressed = !isPressed;
    });
  }
  void addButton() {
    setState(() {
      isPressed2 = !isPressed2;
    });
  }
  AnimeModel? animeData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime Details"),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       isPressed ? Icons.favorite : Icons.favorite_border,
        //       color: isPressed ? Colors.red : null,
        //     ),
        //     onPressed: toggleButton,
        //   ),
        //   IconButton(
        //     icon: isPressed2 ? const Icon(Icons.check) : const Icon(Icons.add),
        //     onPressed: addButton,
        //   ),
        // ],
      ),

      backgroundColor: Colors.black,
      body: FutureBuilder<AnimeModel?>(
          future: widget.animeId != null ? AnimeRepository().getAnimeById(widget.animeId!) : null,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white,));
            }

            else if (snapshot.connectionState == ConnectionState.done) {

              if (snapshot.hasError) {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              }

              else if (snapshot.hasData) {
                animeData = snapshot.data ;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 250,
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                             File(animeData?.animeImage ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                animeData?.animeName ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),//anime Name
                              const SizedBox(height: 8),
                               Text(
                                'Genres: ${animeData?.animeGenre ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),//anime Genres
                              const SizedBox(height: 8),
                              Text(
                                'Episodes: ${animeData?.animeEpisodes.toString() ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),//anime Episodes
                              const SizedBox(height: 8),
                              Text(
                                'Type: ${animeData?.animeType ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),// anime Type
                              const SizedBox(height: 15),
                              Text(
                                'Age range: ${animeData?.animeAge ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),// anime Age
                              const SizedBox(height: 15),
                              Text(
                                'Season: ${animeData?.animeSeason ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),// anime Season
                              const SizedBox(height: 15),
                              Text(
                                'Status: ${animeData?.animeStatus ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),// anime Status
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Rating: ${animeData?.animeRating ?? ''}/10',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Icon(Icons.star_rate,color: Colors.grey),
                                ],
                              ),// anime Rate
                              const SizedBox(height: 15),
                              Text(
                                'Studio: ${animeData?.animeStudio ?? ''} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ), //anime studio
                              const SizedBox(height: 16),
                              const Text(
                                'Summury:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(

                                animeData?.animeDetails ?? '',

                                style: const TextStyle(
                                  fontSize: 16, color: Colors.white,),
                              ), //anime Details
                              const SizedBox(height: 16),
                              Text(
                                "Release date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(animeData?.releaseDate ?? ''))}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ), //release date
                              const SizedBox(height: 8),
                              Text(
                                "Finish date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(animeData?.finishDate ?? ''))}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),//finish date

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              }
            }
            else {
              return Center(child: Text("Error:${snapshot.error.toString()}"));
            }
          }
      ),
    );
  }
}



