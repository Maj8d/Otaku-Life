import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:otaku_life/Models/UserModel.dart';
import 'package:otaku_life/Repository/user_repositpry.dart';
import 'package:otaku_life/profile_page.dart';

import 'Models/AnimeModel.dart';
import 'Repository/anime_repository.dart';
import 'Views/Anime_View/anime_list_view.dart';
import 'animeDetails_page.dart';

class AnimeListAdmin extends StatefulWidget {
   AnimeListAdmin({super.key, required this.userId});
   final int userId;

  @override
  State<AnimeListAdmin> createState() => _AnimeListAdminState();
}

class _AnimeListAdminState extends State<AnimeListAdmin> {
  UserModel? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anime List"),
        leading: FutureBuilder<UserModel?>(
          future: widget.userId != null ? UserRepository().getUserById(widget.userId) : null,
    builder: (context, snapshot) {
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
          userData = snapshot.data;


          return Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)));
              },
              child: ClipOval(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: userData?.userImage != null
                      ? Image.file(
                    File(userData!.userImage??''),height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
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
        return Center(child: Text("Error:${snapshot.error.toString()}",style: TextStyle(color: Colors.red),));
      }
    }
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
      floatingActionButton: SpeedDial(
        overlayOpacity: 0.0,
        backgroundColor: Colors.white,
        activeChild: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        children: [
          // SpeedDialChild(
          //   child: const Icon(Icons.add),
          //   label: 'Classification',
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (BuildContext context) => const ClassificationsListView(),
          //       ),
          //     );
          //   },
          // ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Anime',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const AnimeListView(),
                ),
              );
            },
          ),
        ],
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
