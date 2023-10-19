import 'package:flutter/material.dart';
import 'package:otaku_life/Models/AnimeModel.dart';
import 'package:otaku_life/Repository/anime_repository.dart';
import 'package:otaku_life/Views/Anime_View/add_anime_view.dart';
import 'package:otaku_life/Views/Anime_View/delete_anime_view.dart';
import 'package:otaku_life/Views/Anime_View/update_anime_view.dart';

import '../../animeDetails_page.dart';


class AnimeListView extends StatefulWidget {
  const AnimeListView({Key? key}) : super(key: key);

  @override
  State<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animes List"),
        actions: [IconButton(
          icon: const Icon(Icons.add,color: Colors.white),
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddAnimeView()));
          },
        ),
        ],
      ),
      backgroundColor: Colors.black,

      body: FutureBuilder<List<AnimeModel>>(
          future: AnimeRepository().getAll(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: Colors.white,));
            }

            else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError) {
                return Center(child: Text("Error:${snapshot.error.toString()}"));
              }
              else if(snapshot.hasData){
                var list = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: ()async {
                    setState(() {
                    });
                  },
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  child: ListView.separated(
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AnimeDetails(animeId:list[index].animeId)));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: ListTile(title: Text("${list[index].animeName}",style: const TextStyle(color: Colors.white)),
                              contentPadding: EdgeInsets.zero,
                              leading: Text("${list[index].animeId}",style: const TextStyle(color: Colors.white)),
                              trailing: Container(
                                width: 96,
                                child: Row(
                                  children: [
                                    IconButton(onPressed: ()async{
                                      var updateAnime = await Navigator.of(context).push(MaterialPageRoute(builder:
                                          (context)=>UpdateAnimeView(animeId:  list[index].animeId ?? 0,))
                                      );
                                      if(updateAnime != null && updateAnime == true)
                                      {
                                        setState(() {
                                        });
                                      }
                                    },
                                        icon: const Icon(Icons.edit,color: Colors.white)),

                                    IconButton(onPressed: ()async{
                                      var deleteClassification = await showDialog(context: context, builder: (context){
                                        return DeleteAnimeView(animeId: list[index].animeId ?? 0,);
                                      });
                                      if(deleteClassification != null && deleteClassification == true)
                                      {
                                        setState(() {
                                        });
                                      }
                                    },
                                        icon: const Icon(Icons.delete,color: Colors.white,)),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index){
                        return Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: const Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                        );
                      },
                      itemCount: list.length),
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
