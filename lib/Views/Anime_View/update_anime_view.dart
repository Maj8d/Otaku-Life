import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:otaku_life/Repository/anime_repository.dart';

import '../../Models/AnimeModel.dart';

class UpdateAnimeView extends StatefulWidget {
  const UpdateAnimeView({Key? key, required this.animeId}) : super(key: key);
  final int animeId;

  @override
  State<UpdateAnimeView> createState() => _UpdateAnimeViewState();
}

class _UpdateAnimeViewState extends State<UpdateAnimeView> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";

  String? _imagePath;
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imagePath = pickedImage.path; // Store the image path
      });
    }
  }/////////////pick an image and store the path///////////////////

  final List<String> genres = [
    'Action',
    'Adventure',
    'Cars',
    'Comedy',
    'Demons',
    'Drama',
    'Ecchi',
    'Fiction',
    'Fighting Arts',
    'Games',
    'Harem',
    'Historical',
    'Horror',
    'Isekai',
    'Josei',
    'Kodomomuke',
    'Madness',
    'Magic',
    'Mecha',
    'Mystery',
    'Military',
    'Music',
    'Parody',
    'Police',
    'Psychological',
    'Romance',
    'Samurai',
    'School',
    'Science Fiction',
    'Seinen',
    'Shoujo',
    'Shounen',
    'Slice of Life',
    'Space',
    'Sport',
    'Supernatural',
    'SuperPowers',
    'Thrill',
    'Vampires',
  ];/////the genre list///////////////////

  List<String> _selectedListAnimegenre = [];

  List<AnimeModel>? dataList; // Add this line

  var _selectedAnimestatus;
  var _selectedAnimetype;
  var _selectedAnimeage;
  var _selectedAnimeseason;
  var animeNamectr = TextEditingController();
  var animeDetailsctr = TextEditingController();
  var animeEpisodesctr = TextEditingController();
  var animeStudioctr = TextEditingController();
  var animeReleaseDatectr = TextEditingController();
  var animeFinishDatectr = TextEditingController();
  var animeRatingctr = TextEditingController();


  var formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  final FocusNode _focusNode7 = FocusNode();
  final FocusNode _focusNode8 = FocusNode();
  final FocusNode _focusNode9 = FocusNode();
  final FocusNode _focusNode10 = FocusNode();
  final FocusNode _focusNode11 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _focusNode.unfocus();
        _focusNode2.unfocus();
        _focusNode3.unfocus();
        _focusNode4.unfocus();
        _focusNode5.unfocus();
        _focusNode6.unfocus();
        _focusNode7.unfocus();
        _focusNode8.unfocus();
        _focusNode9.unfocus();
        _focusNode10.unfocus();
        _focusNode11.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Anime'),
        ),

        body: SingleChildScrollView(
          child: FutureBuilder<List<AnimeModel>>(
              future: AnimeRepository().getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                }
                else if (snapshot.connectionState == ConnectionState.done) {

                  if (snapshot.hasError) {
                    return Center(
                        child: Text("Error:${snapshot.error.toString()}"));
                  }

                  else if (snapshot.hasData) {
                    dataList = snapshot.data;
                    int desiredId =  widget.animeId; // Replace "your_desired_id" with the specific ID you want to retrieve
                    AnimeModel desiredData = dataList!.firstWhere((item) => item.animeId == desiredId, orElse: () => AnimeModel(),);

                    animeNamectr.text = desiredData.animeName ?? '';
                    animeDetailsctr.text = desiredData.animeDetails ?? '';
                    _selectedAnimestatus = desiredData.animeStatus ?? '';
                    _selectedAnimetype = desiredData.animeType ?? '';
                    animeStudioctr.text = desiredData.animeStudio ?? '';
                    animeRatingctr.text = desiredData.animeRating.toString();
                    _selectedAnimeage = desiredData.animeAge.toString();
                    _selectedAnimeseason = desiredData.animeSeason.toString();
                    animeEpisodesctr.text = desiredData.animeEpisodes.toString();
                    animeFinishDatectr.text = desiredData.finishDate ?? '';
                    animeReleaseDatectr.text = desiredData.releaseDate ?? '';
                    _imagePath = desiredData.animeImage ?? '';
                    _selectedListAnimegenre.sort();
                    _selectedListAnimegenre = (desiredData.animeGenre ?? '').split(", ");



                      return Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) return "Value is Null!!";

                                if (value.length < 5) {
                                  return "There is no anime name less than 4 letters!!";
                                }
                                return null;
                                                            },
                              controller: animeNamectr,
                              focusNode: _focusNode,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Enter anime name',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0), //name

                            DropdownButtonFormField<String>(
                              value: _selectedAnimeage,
                              onChanged: (String? newValue) {
                                _selectedAnimeage = newValue;
                              },
                              items: <String>['G/All ages', 'PG/7+', 'PG-13/13+', 'R/17+', 'R+/18+']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Select anime age rate',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],

                                //prefixIcon: Icon(Icons.theaters),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an age rate';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),  //Age

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Value Can not be Null!!";
                                if (int.parse(value) > 3000) {
                                  return "Number of episodes are too high!!";
                                }
                                return null;
                              },
                              controller: animeEpisodesctr,
                              focusNode: _focusNode4,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enter number of anime episodes',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],

                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0), //Episodes

                            DropdownButtonFormField<String>(
                              value: _selectedAnimestatus,
                              onChanged: (String? newValue) {
                                  _selectedAnimestatus = newValue;
                              },
                              items: <String>['Finished', 'Continuing', 'Not Released']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Select anime state',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],

                                //prefixIcon: Icon(Icons.theaters),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a state';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0), //Status

                            DropdownButtonFormField<String>(
                              value: _selectedAnimeseason,
                              onChanged: (String? newValue) {
                                  _selectedAnimeseason = newValue;
                              },
                              items: <String>[ 'Winter', 'Spring','Summer','Autumn']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Select anime season',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],

                                //prefixIcon: Icon(Icons.theaters),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a season';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0), //season

                            DropdownButtonFormField<String>(
                              value: _selectedAnimetype,
                              onChanged: (String? newValue) {
                                  _selectedAnimetype = newValue;
                              },
                              items: <String>['Series', 'Movie', 'OVA', 'ONA', 'Special']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Select anime type',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],

                                //prefixIcon: Icon(Icons.theaters),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a type';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0), //Type

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) return "Value is Null!!";

                                if (value.length < 4) {
                                  return "There is no anime studio less than 4 letters!!";
                                }
                                                              return null;
                              },
                              controller: animeStudioctr,
                              focusNode: _focusNode7,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Enter anime studio',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0), //Studio

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Value Can not be Null!!";

                                if (double.parse(value) > 10.0) {
                                  return "Rating is out of 10!!";
                                }
                                                              return null;
                              },
                              keyboardType: TextInputType.number,
                              controller: animeRatingctr,
                              focusNode: _focusNode8,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Enter anime rating',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0), //Rating

                            MultiSelectDialogField(
                              title: const Text('Select Genre'),
                              items: genres.map((genre) => MultiSelectItem<String>(genre, genre)).toList(),
                              initialValue: _selectedListAnimegenre.toList(),
                              validator: (selectedList) {
                                if (selectedList == null || selectedList.isEmpty) {
                                  return 'Please select at least one genre';
                                }
                                return null;
                              },
                              selectedColor: Colors.black,
                              searchable: true,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0),
                              ),

                              onConfirm: (selectedList) {
                                  var data = {
                                    "anime_genre": selectedList.join(", ")
                                  };

                                  AnimeRepository().update(data,widget.animeId);
                                _selectedListAnimegenre = selectedList;
                                  _selectedListAnimegenre.sort();

                              },

                            ),
                            const SizedBox(height: 16.0),////genre selection

                            TextFormField(
                              maxLines: 5,
                              minLines: 5,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) return "Value is Null!!";

                                if (value.length < 5) {
                                  return "There is no anime details less than 4 letters!!";
                                }
                                return null;
                              },
                              controller: animeDetailsctr,
                              focusNode: _focusNode2,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Enter anime details',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),

                            ),
                            const SizedBox(height: 16.0), //Details

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) return "Value is Null!!";

                                if (value.length < 8) return "Not a valid date!!";
                                                              return null;
                              },
                              controller: animeReleaseDatectr,
                              focusNode: _focusNode10,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: 'Enter anime released date',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0), //Release Date

                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) return "Value is Null!!";

                                if (value.length < 8) return "Not a valid date!!";
                                                              return null;
                              },
                              controller: animeFinishDatectr,
                              focusNode: _focusNode11,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: 'Enter anime finished date',
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
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                //prefixIcon: Icon(Icons.theaters),
                              ),
                            ),
                            const SizedBox(height: 16.0),//Finish Date

                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                child: () {
                                   if (_image != null)  {
                                  return Image.file(_image!);
                                  }
                                    if (_imagePath != null) {
                                    return Image.file(
                                      File(_imagePath!),
                                    );
                                  }
                                  else {return const Icon(Icons.add_a_photo);}
                                }(),
                              ),
                            ),
                            const SizedBox(height: 16.0),/////image



                            loading
                                ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                                : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
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
                                      "anime_name": animeNamectr.text.trim(),
                                      "anime_details": animeDetailsctr.text.trim(),
                                      if(_imagePath != null)
                                      "anime_image": _imagePath,
                                      if(_image != null)
                                      "anime_image": _image?.path,
                                      "anime_episodes": animeEpisodesctr.text.trim(),
                                      "anime_type": _selectedAnimetype,
                                      "anime_status": _selectedAnimestatus,
                                      "anime_age": _selectedAnimeage,
                                      "anime_studio": animeStudioctr.text.trim(),
                                      "release_date": animeReleaseDatectr.text.trim(),
                                      "finish_date": animeFinishDatectr.text.trim(),
                                      "anime_rating": animeRatingctr.text.trim(),
                                      "anime_genre": _selectedListAnimegenre.join(", "),
                                      "anime_season":_selectedAnimeseason
                                    };

                                    var updateAnime =
                                    await AnimeRepository().update(data,widget.animeId);
                                    if (updateAnime > 0) {
                                      setState(() {
                                        loading = false;
                                        isSuccess = true;
                                        isError = false;
                                      });
                                      Navigator.of(context).pop(true);
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
                                }
                              },
                              child: const Text('Submit',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            isError
                                ? const Text("Update Operation Failed!!",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center)
                                : const SizedBox(),
                            isSuccess
                                ? const Text("Updated Successfully",
                                style: TextStyle(color: Colors.green),
                                textAlign: TextAlign.center)
                                : const SizedBox()
                          ],
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
                  return Center(
                      child: Text("Error:${snapshot.error.toString()}"));
                }
              }),
        ),
      ),
    );
  }
}
