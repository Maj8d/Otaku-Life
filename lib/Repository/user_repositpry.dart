
import 'package:collection/collection.dart';
import 'package:otaku_life/Models/UserModel.dart';

import '../Data/dp_helper.dart';

class UserRepository
{
  Future<List<UserModel>> getAll()async{
    try{
      var result = await DbHelper().getAll(DbTables.users);
      List<UserModel> list =[];
      if(result != null){
        for(var item in result)
        {
          list.add(UserModel.fromJson(item));
        }
      }
      return list;
    }
    catch(e){
      rethrow;
    }
  }
  Future<int> add(Map<String, dynamic> obj) async {
    try {
      var result = await DbHelper().add(DbTables.users, obj);
      return result;
    } catch (e) {
      return 0;
    }
  }

  Future<int> delete(int id)async{
    try {
      var result = await DbHelper().deleteUser(DbTables.users, id);
      return result;
    }
    catch (e){
      return 0;
    }
  }

  Future<int> update(Map<String, dynamic> obj,int id)async{
    try {
      var result = await DbHelper().updateUser(DbTables.users, obj);
      return result;
    }
    catch (e){
      return 0;
    }
  }

  Future<UserModel?> authenticateUser(String username, String password) async {
    try {
      var userList = await getAll();
      var matchedUser = userList.firstWhereOrNull(
            (user) => user.userName == username && user.userPassword == password,
      );
      return matchedUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUserById(int id)async{
    try {
      var result = await DbHelper().getUserById(DbTables.users, id);

      if (result != null) {
        // Assuming result is a map or object containing the anime details,
        // you need to map it to the AnimeModel object and return it
        return UserModel.fromJson(result);
      }

      return null; // Return null if no anime with the provided id is found
    } catch (e) {
      rethrow;
    }
  }
}