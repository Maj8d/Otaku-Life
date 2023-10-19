import 'package:flutter/material.dart';
import 'package:otaku_life/Repository/classifications_repository.dart';

class DeleteClassificationView extends StatefulWidget {
  const DeleteClassificationView({Key? key, required this.classificationId}) : super(key: key);
  final int classificationId;
  @override
  State<DeleteClassificationView> createState() => _DeleteClassificationViewState();
}

class _DeleteClassificationViewState extends State<DeleteClassificationView> {
  String txt = "Do You Want to Delete This Classification?";
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(Icons.delete),
      content: Container(
        height: 120,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            loading? const CircularProgressIndicator(color: Colors.black,) :Text(txt,style: const TextStyle(fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center),

            isError ? const Text("Delete Operation Failed!!", style: TextStyle(color: Colors.red,),textAlign: TextAlign.center) : const SizedBox(),

            isSuccess ? const Text("Deleted Successfully", style: TextStyle(color: Colors.green),textAlign: TextAlign.center) : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                    onPressed: ()async{
                      try{
                        setState(() {
                          loading = true;
                          isSuccess = false;
                          isError = false;
                        });

                        var deleteClassification = await ClassificationsRepository().delete(widget.classificationId);
                        if(deleteClassification > 0){
                          setState(() {
                            loading = false;
                            isSuccess = true;
                            isError = false;
                          });
                          Navigator.of(context).pop(true);
                        }
                        else{
                          setState(() {
                            loading = false;
                            isSuccess = false;
                            isError = true;
                          });
                        }
                      }
                      catch(e){
                        setState(() {
                          loading = false;
                          isSuccess = false;
                          isError = true;
                          error = "Exp: ${e.toString()}";
                        });
                      }
                    },
                    child: const Text("Yes",style: TextStyle(color: Colors.white),)),

                TextButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                    onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No",style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
