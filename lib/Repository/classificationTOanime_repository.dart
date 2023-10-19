import 'package:otaku_life/Models/Anime_ClassificationsModel.dart';

import '../Data/dp_helper.dart';
import '../Models/ClassificationsModel.dart';

class ClassificationsToAnimeRepository{

  Future<int> add(Map<String, dynamic> obj) async {
    try {
      // Perform database operations to add the classification-to-anime relationship
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().add(DbTables.animeClassifications, obj);
      return result;
    } catch (e) {
      return 0;
    }
  }


  // Future<List<ClassificationsModel>> getClassificationsForAnime(int animeId) async {
  //   try {
  //     // Perform database operations to retrieve the classifications for a specific anime
  //     await Future.delayed(Duration(seconds: 1));
  //     var result = await DbHelper().getClassificationsForAnime(DbTables.animeClassifications, animeId);
  //     List<ClassificationsModel> list = [];
  //     if (result != null) {
  //       for (var item in result) {
  //         list.add(ClassificationsModel.fromJson(item));
  //       }
  //     }
  //     return list;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<List<AnimeClassificationsModel>> getAll()async{
    try{
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().getAll(DbTables.animeClassifications);
      List<AnimeClassificationsModel> list =[];
      if(result != null){
        for(var item in result)
        {
          list.add(AnimeClassificationsModel.fromJson(item));
        }
      }
      return list;
    }
    catch(e){
      rethrow;
    }
  }
}