
import 'package:otaku_life/Data/dp_helper.dart';
import 'package:otaku_life/Models/AnimeModel.dart';

class AnimeRepository{
  Future<List<AnimeModel>> getAll()async{
    try{
      var result = await DbHelper().getAll(DbTables.anime);
      List<AnimeModel> list =[];
      if(result != null){
        for(var item in result)
        {
          list.add(AnimeModel.fromJson(item));
        }
        list.sort((a, b) => a.animeName?.compareTo(b.animeName!) ?? 0);      }
      return list;
    }
    catch(e){
      rethrow;
    }
  }

  Future<AnimeModel?> getAnimeById(int id)async{
    try {
      var result = await DbHelper().getById(DbTables.anime, id);

      if (result != null) {
        // Assuming result is a map or object containing the anime details,
        // you need to map it to the AnimeModel object and return it
        return AnimeModel.fromJson(result);
      }

      return null; // Return null if no anime with the provided id is found
    } catch (e) {
      rethrow;
    }
  }
  Future<List<AnimeModel>> getAnimeByName(String name) async {
    try {
      var result = await DbHelper().getByName(DbTables.anime, name, pkName: "animeName");

      List<AnimeModel> list = [];
      if (result.isNotEmpty) {
        for (var item in result) {
          list.add(AnimeModel.fromJson(item));
        }
        list.sort((a, b) => a.animeName?.compareTo(b.animeName!) ?? 0);
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> add(Map<String, dynamic> obj) async {
    try {
      // Convert the anime_genre list to a JSON string
      // List<String> animeGenre = obj['anime_genre'] ?? [];
      // String genreJson = jsonEncode(animeGenre);
      //
      // // Update the obj map with the JSON string
      // obj['anime_genre'] = genreJson;

      var result = await DbHelper().add(DbTables.anime, obj);
      return result;
    } catch (e) {
      return 0;
    }
  }

  Future<int> delete(int id)async{
    try {
      var result = await DbHelper().deleteanime(DbTables.anime, id);
      return result;
    }
    catch (e){
      return 0;
    }
  }

  Future<int> update(Map<String, dynamic> obj,int id)async{
    try {
      var result = await DbHelper().updateanime(DbTables.anime, obj);
      return result;
    }
    catch (e){
      return 0;
    }
  }
  // Future<int> update(Map<String, dynamic> obj,int id)async{
  //   try {
  //     await Future.delayed(Duration(seconds: 1));
  //     var result = await DbHelper().updateanime(DbTables.Anime, obj);
  //     return result;
  //   }
  //   catch (e){
  //     return 0;
  //   }
  }

