import 'package:flutter/material.dart';
import 'package:otaku_life/Models/ClassificationsModel.dart';
import 'package:otaku_life/Repository/classifications_repository.dart';
import 'package:otaku_life/Views/Classifications_View/add_classifications_view.dart';
import 'package:otaku_life/Views/Classifications_View/delete_classifications_view.dart';
import 'package:otaku_life/Views/Classifications_View/update_classifications_view.dart';

class ClassificationsListView extends StatefulWidget {
  const ClassificationsListView({Key? key}) : super(key: key);

  @override
  State<ClassificationsListView> createState() => _ClassificationsListViewState();
}

class _ClassificationsListViewState extends State<ClassificationsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Classifications List"),
        actions: [IconButton(
          icon: const Icon(Icons.add,color: Colors.white),
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddClassificationView()));
            // var isAdd = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddClassificationView()));
            // if(isAdd != null && isAdd == true)
            //   {
            //     setState(() {
            //     });
            //   }
          },
        ),
        ],
          ),

      backgroundColor: Colors.black,

      body: FutureBuilder<List<ClassificationsModel>>(
        future: ClassificationsRepository().getAll(),
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
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: ListTile(title: Text("${list[index].classificationName}",style: const TextStyle(color: Colors.white)),
                        contentPadding: EdgeInsets.zero,
                        leading: Text("${list[index].classificationId}",style: const TextStyle(color: Colors.white)),
                        trailing: Container(
                          width: 96,
                          child: Row(
                            children: [
                              IconButton(onPressed: ()async{
                                var updateClassification = await Navigator.of(context).push(MaterialPageRoute(builder:
                                    (context)=>UpdateClassificationList(classificationId:  list[index].classificationId ?? 0,))
                                );
                                if(updateClassification != null && updateClassification == true)
                                {
                                  setState(() {
                                  });
                                }
                              },
                                  icon: const Icon(Icons.edit,color: Colors.white)),

                              IconButton(onPressed: ()async{
                                  var deleteClassification = await showDialog(context: context, builder: (context){
                                    return DeleteClassificationView(classificationId: list[index].classificationId ?? 0,);
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
