import 'package:flutter/material.dart';
import 'package:otaku_life/Repository/classifications_repository.dart';

class AddClassificationView extends StatefulWidget {
  const AddClassificationView({Key? key}) : super(key: key);

  @override
  State<AddClassificationView> createState() => _AddClassificationViewState();
}

class _AddClassificationViewState extends State<AddClassificationView> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";

  var classificationsNamectr = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Add Classification'),

        ),

        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null) {
                      return "*Value is Null";
                    }

                      if(value.length < 5) {
                        return "There is no Classification less than 4 letters";
                      }
                                        return null;
                  },
                  controller: classificationsNamectr,
                  focusNode: _focusNode,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(

                    labelText: 'Enter Anime Classification',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.red
                    )),
                    filled: true,
                    fillColor: Colors.grey[200],
                    //prefixIcon: Icon(Icons.theaters),
                  ),
                ),
                const SizedBox(height: 16.0),

               loading? const CircularProgressIndicator(color: Colors.black,) : ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: ()async {
                    if(formKey.currentState!.validate())
                    {
                      try{
                        setState(() {
                          loading = true;
                          isSuccess = false;
                          isError = false;
                        });
                        var data = {

                          "classification_name": classificationsNamectr.text
                        };
                        var addClassification = await ClassificationsRepository().add(data);
                        if(addClassification > 0){
                          setState(() {
                            loading = false;
                            isSuccess = true;
                            isError = false;
                          });

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
                    }
                    else {
                      print("Form is not VALID");
                    }
                  },
                  child: const Text('Submit',style: TextStyle(color: Colors.white)),
                ),

               isError ? const Text("Adding Operation Failed!!", style: TextStyle(color: Colors.red),textAlign: TextAlign.center) : const SizedBox(),

               isSuccess ? const Text("Added Successfully", style: TextStyle(color: Colors.green),textAlign: TextAlign.center) : const SizedBox()

              ],
            ),
          ),
        ),
      ),
    );

  }
  }

