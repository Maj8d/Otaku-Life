import 'package:otaku_life/Data/dp_helper.dart';
import 'package:otaku_life/Models/ClassificationsModel.dart';

class ClassificationsRepository{
  Future<List<ClassificationsModel>> getAll()async{
    try{
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().getAll(DbTables.classifications);
      List<ClassificationsModel> list =[];
      if(result != null){
        for(var item in result)
          {
            list.add(ClassificationsModel.fromJson(item));
          }
      }
      return list;
    }
    catch(e){
      rethrow;
    }
  }

  Future<int> add(Map<String, dynamic> obj)async{
    try {
      await Future.delayed(Duration(seconds: 1));

      var result = await DbHelper().add(DbTables.classifications, obj);
      return result;
    }
    catch (e){
      return 0;
    }
  }

  Future<int> delete(int id)async{
    try {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().delete(DbTables.classifications, id);
      return result;
    }
    catch (e){
      return 0;
    }
  }

  Future<int> update(Map<String, dynamic> obj,int id)async{
    try {
      await Future.delayed(Duration(seconds: 1));
      var result = await DbHelper().update(DbTables.classifications, obj);
      return result;
    }
    catch (e){
      return 0;
    }
  }


}