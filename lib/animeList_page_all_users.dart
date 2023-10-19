import 'dart:io';
import 'package:flutter/material.dart';
import 'package:otaku_life/log_in.dart';
import 'Models/AnimeModel.dart';
import 'Models/UserModel.dart';
import 'Repository/anime_repository.dart';
import 'animeDetails_page.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key, this.userId}) : super(key: key);
  final int? userId;

  @override
  State<AnimeList> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {

UserModel? userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime List"),
        leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  LogIn()));
                    },

                    child:    const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person,color: Colors.white,size: 40,),
                    ),
                  ),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search screen');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<AnimeModel>>(
          future: AnimeRepository().getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              } else if (snapshot.hasData) {
                var list = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                                height: 130,
                                margin: const EdgeInsets.all(7),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnimeDetails(animeId:list[index].animeId)));
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 90,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                              child: list[index].animeImage != null
                                                  ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.file(
                                                File(list[index].animeImage!),
                                                fit: BoxFit.cover,
                                              ),
                                                  )
                                                  : Container()),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 115,
                                                  child: ListTile(
                                                    title: Text(
                                                        "${list[index].animeName}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white)),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text("${list[index].animeStatus}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Text("${list[index].animeType}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),

                        );
                      },
                      itemCount: list.length
                  ),
                );
              } else {
                return Center(
                    child: Text("Error:${snapshot.error.toString()}"));
              }
            } else {
              return Center(child: Text("Error:${snapshot.error.toString()}"));
            }
          }),
    );
  }
}
