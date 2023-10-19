import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:otaku_life/Models/AnimeModel.dart';
import 'package:otaku_life/Models/Anime_ClassificationsModel.dart';
import 'package:otaku_life/Models/ClassificationsModel.dart';
import 'package:otaku_life/Repository/anime_repository.dart';
import 'package:otaku_life/Repository/classificationTOanime_repository.dart';

import '../../Repository/classifications_repository.dart';

class AddAnimeClassifications extends StatefulWidget {
  const AddAnimeClassifications({super.key, this.animeId});
  final animeId;

  @override
  State<AddAnimeClassifications> createState() => _AddAnimeClassificationsState();
}

class _AddAnimeClassificationsState extends State<AddAnimeClassifications> {
  var formKey = GlobalKey<FormState>();
  var animeNamectr = TextEditingController();

  List<ClassificationsModel> _selectedAnimesClassification = [];
  List<ClassificationsModel> _selectedClassification = [];
  List<ClassificationsModel>? dataListclass;
  AnimeModel? dataList;
  var _selectedClass;

  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (BuildContext context) {
            return FutureBuilder<AnimeModel?>(
              future: AnimeRepository().getAnimeById(widget.animeId),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                return const Align(alignment: Alignment.bottomCenter,child: CircularProgressIndicator(color: Colors.black,));
                }

    else if (snapshot.connectionState == ConnectionState.done) {

                  if (snapshot.hasError) {
                    return Center(child: Text("Error:${snapshot.error
                        .toString()}"));
                  }
                else if(snapshot.hasData) {
                    dataList = snapshot.data as AnimeModel?;
                    animeNamectr.text = dataList != null ? dataList!.animeName ?? '' : '';

                    return AppBar(
                      title: Text("${animeNamectr.text} Genres",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                    );
                  }
                  else {
                    return Center(
                        child: Text("Error:${snapshot.error.toString()}"));
                  }
                }
                else {
                  return Center(
                      child: Text("Error:${snapshot.error.toString()}"));
                }
              }
            );
          },
        ),
      ),

        body:SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Column(
                children: [

                  FutureBuilder<List<ClassificationsModel>>(
                    future: ClassificationsRepository().getAll(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Align(alignment: Alignment.topCenter,
            child: CircularProgressIndicator(color: Colors.black,));
      }

      else if (snapshot.connectionState == ConnectionState.done) {

        if (snapshot.hasError) {
          return Center(child: Text("Error:${snapshot.error.toString()}"));
        }

        else if (snapshot.hasData) {
          _selectedClassification = snapshot.data!;
          _selectedClass = dataListclass?.isNotEmpty ?? false ? dataListclass![0].classificationName ?? '' : '';


          return MultiSelectDialogField<ClassificationsModel>(
            items: _selectedClassification.map((classification) {
              return MultiSelectItem<ClassificationsModel>(
                classification,
                classification.classificationName!,
              );
            }).toList(),
            initialValue: _selectedAnimesClassification.isNotEmpty
                ? _selectedAnimesClassification
                : [],
            validator: (values) {
              if (values == null || values.isEmpty) {
                return 'Please select at least one classification';
              }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedAnimesClassification = values;
              });
            },
            title: Text('Select anime classification'),
            selectedColor: Colors.blue,
            buttonText: Text('Select'),
            chipDisplay: MultiSelectChipDisplay(
              onTap: (item) {
                setState(() {
                  _selectedAnimesClassification.remove(item);
                });
              },
            ),
          );
        }

        else {
          return Center(
              child: Text("Error:${snapshot.error.toString()}"));
        }
      }

      else {
        return Center(
            child: Text("Error:${snapshot.error.toString()}"));
      }
    }
                  ),

                  SizedBox(height: 16),


                  loading
                      ? CircularProgressIndicator(color: Colors.black)
                      : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            loading = true;
                            isSuccess = false;
                            isError = false;
                          });
                          var data = {
                            "anime_id": widget.animeId,
                            "classification_id": _selectedAnimesClassification.map((classification) => classification.classificationId).toList(),
                          };
                          var addClassification = await ClassificationsToAnimeRepository().add(data);
                          if (addClassification > 0) {
                            setState(() {
                              loading = false;
                              isSuccess = true;
                              isError = false;
                            });
                          } else {
                            setState(() {
                              loading = false;
                              isSuccess = false;
                              isError = true;
                            });
                          }
                        } catch (e) {
                          setState(() {
                            loading = false;
                            isSuccess = false;
                            isError = true;
                            error = "Exp: ${e.toString()}";
                          });
                        }
                      } else {
                        print("Form is not valid");
                      }
                    },
                    child: const Text('Submit', style: TextStyle(color: Colors.white)),
                  ),
                  isError
                      ? Text(
                    "Adding Operation Failed!!",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  )
                      : SizedBox(),
                  isSuccess
                      ? Text(
                    "Added Successfully",
                    style: TextStyle(color: Colors.green),
                    textAlign: TextAlign.center,
                  )
                      : SizedBox(),

                ],


              ),
            ),
          ),
        ),
    );
  }
}
